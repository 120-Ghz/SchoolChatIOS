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
        manager.react_chats(complete: FillChats2)
        manager.react_con(completionHandler: FillChats)
        manager.recieve_chats(complete: FillChats3)
    }
    
    func FillChats() {
        manager.get_chat_ids(user_id: USER?.id ?? 0)
    }
    
    func FillChats2(incoming: NSArray) {
        //print(" aboba")
        var chat_ids = [Int64]()
        for elem in incoming {
            let id = Int64(((elem as! [String: Any])["chat_id"] as! NSString) as String)!
            chat_ids.append(id)
        }
        print(chat_ids)
        for chat in chat_ids{
            manager.request_chat_data(chat_id: chat)
        }
    }
    
    func FillChats3(incoming: [String:Any]){
        
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
                        ChatMiniPreview(chat: chat)
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
