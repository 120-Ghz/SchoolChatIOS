//
//  ChatView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    
    @Published private(set) var messages: [Message] = []
    @Published var scroll = false
    @Published var Users: [User] = []
    
    var chat_id: Int64 = 0
    var manager = SocketIOManager()
    
    func connect() {
        manager.observeMessages(completionHandler: NewMsg)
        manager.recieve_chat_msgs(completionHandler: getMessages)
        manager.recieve_chat_users(completionHandler: get_users)
        manager.message_deleted(completionHandler: deletedMessageHandler)
        manager.message_edited(completionHandler: editedMessageHandler)
        request_users()
    }
    
    func deletedMessageHandler(incoming: [String: Any]) {
        if (incoming["stat"] as? String ?? "" != "OK") {
            return
        }
        guard let data = incoming["data"] as? [String: Any] else {return}
        guard let id = data["id"] as? Int64 else {return}
        let index = get_msg_index_by_id(id: id)
        if index == -1 {
            return
        }
        messages.remove(at: index)
    }
    
    func editedMessageHandler(incoming: [String: Any]) {
        if (incoming["stat"] as? String ?? "" != "OK") {
            return
        }
        guard let data = incoming["data"] as? [String: Any] else {return}
        let id = Int64(data["id"] as? String ?? "") ?? 0
        let index = get_msg_index_by_id(id: id)
        if index == -1 {
            return
        }
        withAnimation {
            messages[index].edited = true
            messages[index].attachments = data["attachments"] as? [String: Any] ?? [:]
            messages[index].text = data["text"] as? String ?? messages[index].text
            messages[index].time = (data["updatedAt"] as? String ?? "").JSDateToDate()
        }
    }
    
    func request_users() {
        manager.request_chat_users(chat_id: chat_id)
    }
    
    func get_users(incoming: [Any]) {
        for raw in incoming {
            var r = raw as! [Any]
            if (r.count == 0) {
                continue
            }
            guard let data = r[0] as? [String: Any] else {continue}
            let user = User(id: Int64(data["id"] as? String ?? "") ?? 0, name: data["name"] as? String ?? "", surname: data["surname"] as? String ?? "", school_id: Int64(data["school_id"] as? String ?? "") ?? 0, class_id: Int64(data["class_id"] as? String ?? "") ?? 0, email: data["email"] as? String ?? "", phone: data["phone"] as? String ?? "", avatar: data["picture_url"] as? String ?? "")
            if (!Users.contains(user)) {
                Users.append(user)
            }
        }
    }
    private func NewMsg(incoming: Message) {
        if (incoming.chat_id == chat_id) && (!incoming.deleted_all) {
            if get_msg_index_by_id(id: incoming.id) != -1 {
                print("bug")
                return
            }
            messages.append(incoming)
            messages = messages.sorted { return $0.id < $1.id }
            scroll.toggle()
        }
    }
    
    func sendMessage(message: Message) {
        manager.send(user_id: message.user_id, chat_id: message.chat_id, text: message.text, attachments: message.attachments)
    }
    
    private func get_msg_index_by_id(id: Int64) -> Int {
        if messages.count == 0 { return -1 }
        for i in 0...messages.count-1 {
            if messages[i].id == id  {
                return i
                
            }
        }
        return -1
    }
    
    func getMessages(incoming: [String:Any]) {
        if (incoming["stat"] as! String) != "OK" {
            return
        }
        
        let msg = incoming["data"] as! [String: Any]
        if get_msg_index_by_id(id: Int64(msg["id"] as! String)!)  != -1 {
            return
        }
        messages.append(Message(id: Int64(msg["id"] as? String ?? "") ?? 0, chat_id: Int64(msg["chat_id"] as? String ?? "") ?? 0, user_id: Int64(msg["user_id"] as? String ?? "") ?? 0, text: msg["text"] as? String ?? "", attachments: msg["attachments"] as? [String:Any] ?? [:], deleted_all: msg["deleted_all"] as? Bool ?? false, deleted_user: msg["deleted_user"] as? Bool ?? false, edited: msg["edited"] as? Bool ?? false, time: (msg["createdAt"] as? String ?? "").JSDateToDate(), service: msg["service"] as? Bool ?? false, user_name: msg["user_name"] as? String ?? "", user_pic: msg["user_pic_url"] as? String ?? ""))
        messages = messages.sorted { return $0.id < $1.id }
        scroll.toggle()
    }
    
    func requestMessages() {
        manager.requestChatMsgs(user_id: USER!.id, chat_id: chat_id)
    }
    
    func delete_message_for_all(id: Int64) {
        manager.delete_msg_for_all(id: id)
    }
    
    func delete_message_for_user(id: Int64) {
        manager.delete_msg_for_user(id: id)
    }
    
    func edit_message(id: Int64, text: String) {
        manager.edit_msg(id: id, text: text)
    }
}

struct ChatView: View {
    
    @State private var message = ""
    @ObservedObject var back: NavigationBeetweenChats
    @StateObject private var model: ChatViewModel = ChatViewModel()
    @State private var lastMessageUUID: UUID?
    @State private var isFirst: Bool = true
    @State private var editing: Bool = false
    @State private var EditingMessage: Message?
    @State var LinkToInfo = false
    
    var chat: Chat
    
    private func onAppear() {
        if !LinkToInfo {
            model.chat_id = chat.id
            model.connect()
            model.requestMessages()
        }
        LinkToInfo = false
        back.Allower = false
        //        print(CryptManagerWrapper().comparePassword("", "aboba"))
    }
    
    private func ScrollToMessage(messageUUID: UUID, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil) {
                scrollReader.scrollTo(messageUUID, anchor: anchor)
            }
        }
    }
    
    private func send_button() {
        print("ABOBA")
        if editing {
            edit()
            return
        }
        if !message.isEmpty {
            model.sendMessage(message: Message(id: Int64(model.messages.count), chat_id: model.chat_id, user_id: USER?.id ?? 0, text: message, attachments: [:], deleted_all: false, deleted_user: false, edited: false, time: Date.now, service: false, user_name: "", user_pic: ""))
            message = ""
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]
    
    private func contextButton(text: String, img: String) -> some View{
        return HStack {
            Text(text)
            Spacer()
            Image(systemName: img)
        }
    }
    
    private func reply(msg: Message) {
        print("reply", chat.name)
    }
    
    private func copy(msg: Message) {
        print("copy")
        UIPasteboard.general.string = msg.text
        // TODO: Add success notification (optional)
    }
    
    private func delete(for_all: Bool, msg: Message) {
        if for_all {
            model.delete_message_for_all(id: msg.id)
        } else {
            model.delete_message_for_user(id: msg.id)
        }
    }
    
    private func edit() {
        model.edit_message(id: EditingMessage!.id, text: message)
        editing = false
        message = ""
    }
    
    private func ctxMenu(msg: Message) -> some View {
        return Group {
            
            if (msg.user_id == USER?.id && !chat.left) {
                Button(action: {
                    editing = true
                    message = msg.text
                    EditingMessage = msg
                }) {
                    contextButton(text: "Edit", img: "pencil")
                }
            }
            if (!chat.left) {
                Button(action: {
                    reply(msg: msg)
                }) {
                    contextButton(text: "Reply", img: "arrowshape.turn.up.right")
                }
            }
            
            Button(action: {
                copy(msg: msg)
            }) {
                contextButton(text: "Copy", img: "doc.on.doc")
            }
            
            Button(role: .destructive) {
                delete(for_all: false, msg: msg)
            } label: {
                contextButton(text: "Delete for me", img: "trash")
            }
            if ((msg.user_id == USER?.id || chat.creator == USER?.id || chat.admins.contains(USER!.id)) && !chat.left){
                Button(role: .destructive) {
                    delete(for_all: true, msg: msg)
                } label: {
                    contextButton(text: "Delete for all", img: "trash")
                }
            }
        }
    }
    
    private func MessagesView() -> some View {
        ForEach(model.messages) { message in
            Spacer()
                .frame(height: 2)
            MessageView(message: message, ctxmenu: AnyView(ctxMenu(msg: message)))
                .id(message.InternalId)
        }
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollViewReader { scrollReader in
                    VStack {
                        MessagesView()
                            .onChange(of: model.scroll) { _ in
                                lastMessageUUID = model.messages.last?.InternalId
                                ScrollToMessage(messageUUID: lastMessageUUID!, anchor: nil, shouldAnimate: !isFirst, scrollReader: scrollReader)
                                if isFirst {
                                    isFirst = !isFirst
                                }
                            }
                    }
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [.white, .cyan.opacity(0.3)]), startPoint: .topTrailing, endPoint: .bottomLeading))
            if (chat.left) {
                Text("You cannot send messages to this channel")
            } else {
                VStack {
                    if editing {
                        MessageEditingMiniTable()
                    }
                    HStack {
                        TextField("Message", text: $message, onEditingChanged: {_ in}, onCommit: send_button)
                            .padding(10)
                            .background(Capsule().fill(Color.gray.opacity(0.3)))
                            .padding(.horizontal)
                        Button(action: send_button) {
                            Image(systemName: "arrow.turn.up.right")
                                .font(.system(size: 20))
                        }
                        .padding(.horizontal)
                        .disabled(message.isEmpty)
                    }
                    .padding(.top)
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(leading: leadingBtn)
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
    
    private func onDisappear() {
        if LinkToInfo {
            return
        }
        back.toggler.toggle()
    }
    
    var leadingBtn: some View {
        HStack {
            NavigationLink(destination: ChatInfoView(chat: chat, users: model.Users)) {
                HStack {
                    ChatPicture(chat: chat, frameRadius: 40)
                        .frame(width: 40, height: 40)
                        .padding(.horizontal, 0)
                    Text(chat.name)
                        .bold()
                        .foregroundColor(Color.black)
                        .padding(.horizontal, 3)
                }
            }
            .simultaneousGesture(TapGesture().onEnded{
                print("aboba")
                LinkToInfo = true
            })
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(back: NavigationBeetweenChats(), chat: Chat(id: 2, name: "Test Chat", creator: 2, picture_url: "", deleted: false, hasLastMsg: true, last_msg_text: "Aboba", last_msg_user: 1, last_msg_time: Date.now, last_msg_username: "", last_msg_userpic: "", admins: [], left: false))
    }
}

