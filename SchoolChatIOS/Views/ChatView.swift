//
//  ChatView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

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
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(model.messages) { message in
                Spacer()
                    .frame(height: 2)
                MessageView(message: message, ctxmenu: AnyView(ctxMenu(msg: message)))
                    .id(message.InternalId)
            }
        }
    }
    
    var body: some View {
        VStack {
            GeometryReader {reader in
                VStack {
                    ScrollView(.vertical) {
                        ScrollViewReader { scrollReader in
                            MessagesView()
                                .onChange(of: model.scroll) { _ in
                                    lastMessageUUID = model.messages.last?.InternalId
                                    ScrollToMessage(messageUUID: lastMessageUUID!, anchor: .bottom, shouldAnimate: !isFirst, scrollReader: scrollReader)
                                    if isFirst {
                                        isFirst = !isFirst
                                    }
                                }
                        }
                    }
                }
            }
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
                    .opacity(0.8)
                }
            }
        }
        .padding(.top, 1)
        .background(LinearGradient(gradient: Gradient(colors: [.white, .cyan.opacity(0.3)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .navigationBarTitleDisplayMode(.inline)
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
