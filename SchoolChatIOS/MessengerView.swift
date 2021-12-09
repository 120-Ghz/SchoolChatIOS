//
//  MessengerView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

final class MessengerViewModel: ObservableObject {
    
    @Published private(set) var chats: [Chat] = []
    
    var manager = SocketIOManagerDefault()
    
    func connect() {
        manager.establishConnection()
        manager.react_chats(completionHandler: FillChats2)
        manager.react_con(completionHandler: FillChats)
        manager.recieve_chats(completionHandler: FillChats3)
    }
    
    func FillChats() {
        manager.get_chat_ids(user_id: USER?.id ?? 2)
    }
    
    func FillChats2(incoming: [Any]) {
        //print(" aboba")
        print(incoming)
        for chat in incoming {
            manager.request_chat_data_for_preview(chat_id: Int64(chat as! String) ?? 0)
        }
    }
    
    func FillChats3(incoming: [String:Any]){
        let chatinfo = incoming["chat"] as! [String: Any]
        let last_msg_info = incoming["last_msg"] as! [String: Any]
        chats.append(Chat(id: Int64(chatinfo["id"] as! String)!, name: chatinfo["name"] as! String, creator: Int64(chatinfo["creator"] as! String)!, picture_url: "\(chatinfo["pic"])", deleted: false, last_msg_text: last_msg_info["text"] as! String, last_msg_user: Int64(last_msg_info["user_id"] as! String) ?? 0, last_msg_time: "\(last_msg_info["time"])"))
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
    
    private func onAppear(){
        model.connect()
    }
    
    private func onDisappear(){
        model.disconnect()
    }
    
    private func onCommit() {
        model.FillChats()
    }
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVStack(spacing: 8){
                    ForEach(model.chats) { chat in
                        Button(action: {}) {
                            ChatMiniPreview(chat: chat)
                        }
                    }
                }
            }
        }
        HStack {
            Button(action:onCommit) {
                Image(systemName: "arrow.turn.up.right")
                    .font(.system(size: 20))
            }
            .padding()
        }
        .padding()
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
}

struct MessengerView_Previews: PreviewProvider {
    static var previews: some View {
        MessengerView()
    }
}
