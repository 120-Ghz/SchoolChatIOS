//
//  MessengerView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

final class MessengerViewModel: ObservableObject {
    
    @Published private(set) var chats: [Chat] = []
    @Published var AllowUpdate: Bool = true
    
    var manager = SocketIOManager()
    
    func create() {
        manager.react_chats(completionHandler: FillChats2)
        manager.react_con(completionHandler: FillChats)
        manager.recieve_chats(completionHandler: FillChats3)
        manager.observeMessages(completionHandler: FillChatsWhenMessageForUser)
    }
    
    func FillChats() {
//        chats = LocalManager.get_chats()
        manager.get_chat_ids(user_id: USER?.id ?? 2)
    }
    
    private func FindChatIndex(chat_id: Int64) -> Int{
        if chats.count == 0 {
            return -1
        }
        for i in 0...chats.count-1 {
            if (chats[i].id == chat_id) {
                return i
            }
        }
        return -1
    }
    
    func FillChatsWhenMessageForUser(message: Message) {
        if !AllowUpdate {return}
        let index = FindChatIndex(chat_id: message.chat_id)
        if (index == -1) { return }
        chats.remove(at: index)
        manager.request_chat_data_for_preview(chat_id: message.chat_id)
    }
    
    func FillChats2(incoming: [Any]) {
        //print(" aboba")
        for chat in incoming {
            print("requested new")
            manager.request_chat_data_for_preview(chat_id: Int64(chat as! String) ?? 0)
        }
    }
    
    func DataWorker(chat: Chat) {
        for cchat in chats {
            if (chat == cchat) {
                return
            }
        }
        let index = FindChatIndex(chat_id: chat.id)
        if index != -1 {
            chats.remove(at: index)
        }
        chats.append(chat)
    }
    
    func FillChats3(incoming: [String:Any]){
        let chatinfo = incoming["chat"] as! [String: Any]
        let last_msg_info = incoming["last_msg"] as! [String: Any]
        let last_msg_time = (last_msg_info["time"] as! String)
        let last_msg_stat = !(last_msg_time.count == 0)
        let raw_admins = chatinfo["admins"] as! [Any]
//        print(chatinfo)
        var chat_admins: [Int64] = []
        for admin in raw_admins {
            chat_admins.append(Int64(admin as! String)!)
        }
        guard let userdata = last_msg_info["userdata"] as? [String: Any] else {return}
        DataWorker(chat: Chat(id: Int64(chatinfo["id"] as! String)!, name: chatinfo["name"] as! String, creator: Int64(chatinfo["creator"] as! String)!, picture_url: chatinfo["pic"] as? String ?? "", deleted: false, hasLastMsg: last_msg_stat, last_msg_text: last_msg_info["text"] as! String, last_msg_user: Int64(last_msg_info["user_id"] as! String) ?? 0, last_msg_time: (last_msg_info["time"] as! String).JSDateToDate(), last_msg_username: "\(userdata["name"]) \(userdata["surname"])", admins: chat_admins, left: chatinfo["left"] as! Bool))
    }
    
    func disconnect(){
        manager.closeConnection()
    }

    deinit {
        disconnect()
    }
}

struct MessengerView: View {
    
    @StateObject private var model = MessengerViewModel()
    @StateObject private var updater = NavigationBeetweenChats()
    
    @State var AddChatsShow = false
    @State private var ConfirmDelete = false
    @State private var ConfirmLeave = false
    
    private func onAppear(){
        model.create()
    }
    
    private func onCommit() {
        model.FillChats()
    }
    
    private func onChange(state: Bool) {
        model.FillChats()
        model.AllowUpdate = true
        updater.Allower = true
    }
    
    private func BlockUpdates(state: Bool) {
        if updater.Allower {return}
        model.AllowUpdate = false
    }
    
    private var PlusButton: some View {
        NavigationLink(destination: NewChatView(back: updater)) {
            Image(systemName: "plus")
        }
    }
    
    private func Row(chat: Chat) -> some View {
        return ZStack {
            
            ChatRow(chat: chat)
            
            NavigationLink(destination: {
                ChatView(back: updater, chat: chat)
            }) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 0)
            .opacity(0)
        }
    }
    
    private func LeaveChat(chat: Chat) {
        print("leave")
    }
    
    private func DeleteChat(chat: Chat) {
        print("delete")
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(model.chats) { chat in
                        Row(chat: chat)
                            .swipeActions(edge: .trailing) {
        
                                if (chat.creator == USER!.id) {
                                    Button(action: {
                                        ConfirmDelete = true
                                    }) {
                                        VStack {
                                            Image(systemName: "trash")
                                            Text("Delete")
                                        }
                                    }.tint(.red)
                                }
                                
                                Button(action: {
                                    ConfirmLeave = true
                                }) {
                                    VStack {
                                        Image(systemName: "")
                                        Text("Leave")
                                    }
                                }
                                .tint(.blue)
                            }
                            .confirmationDialog("Are you sure?", isPresented: $ConfirmLeave, titleVisibility: .visible) {
                                Button("Yes", role: .destructive) {
                                    LeaveChat(chat: chat)
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                            .confirmationDialog("Are you sure you want delete \(chat.name)?", isPresented: $ConfirmDelete, titleVisibility: .visible) {
                                Button("Yes", role: .destructive) {
                                    DeleteChat(chat: chat)
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Chats", displayMode: .inline)
                .navigationBarItems(trailing: PlusButton)
            }
        }
        .onAppear(perform: onAppear)
        .onChange(of: updater.toggler, perform: onChange)
        .onChange(of: updater.Allower, perform: BlockUpdates)
    }
}

struct MessengerView_Previews: PreviewProvider {
    static var previews: some View {
        MessengerView()
    }
}
