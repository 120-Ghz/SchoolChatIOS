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
        chats = []
        manager.get_chat_ids(user_id: USER?.id ?? 2)
    }
    
    func Check_if_message_in_user_chats(message: Message) -> Bool {
        for ch in chats {
            if message.chat_id == ch.id {
                return true
            }
        }
        return false
    }
    
    func FillChatsWhenMessageForUser(message: Message) {
        if !AllowUpdate {return}
        if !Check_if_message_in_user_chats(message: message) { return }
        let chs = chats
        chats = []
        for chat in chs {
            manager.request_chat_data_for_preview(chat_id: chat.id)
        }
    }
    
    func FillChats2(incoming: [Any]) {
        //print(" aboba")
        for chat in incoming {
            manager.request_chat_data_for_preview(chat_id: Int64(chat as! String) ?? 0)
        }
    }
    
    func FillChats3(incoming: [String:Any]){
        let chatinfo = incoming["chat"] as! [String: Any]
        let last_msg_info = incoming["last_msg"] as! [String: Any]
        chats.append(Chat(id: Int64(chatinfo["id"] as! String)!, name: chatinfo["name"] as! String, creator: Int64(chatinfo["creator"] as! String)!, picture_url: chatinfo["pic"] as? String ?? "", deleted: false, last_msg_text: last_msg_info["text"] as! String, last_msg_user: Int64(last_msg_info["user_id"] as! String) ?? 0, last_msg_time: (last_msg_info["time"] as! String).JSDateToDate()))
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
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(model.chats) { chat in
                        ZStack {
                            
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
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Chats", displayMode: .inline)
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
