//
//  ChatView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    
    @Published private(set) var messages: [Message] = []
    
    var chat_id: Int64 = 0
    
    var manager = SocketIOManager()
    
    func connect() {
        manager.observeMessages(completionHandler: NewMsg)
    }
    
    func disconnect(){
        manager.closeConnection()
    }
    
    private func NewMsg(incoming: Message) {
        print("handled")
        if (incoming.chat_id == chat_id) && (!incoming.deleted_all){
            messages.append(incoming)
        }
    }
    
    func sendMessage(message: Message) {
        manager.send(message: message)
    }
    
    deinit {
        disconnect()
    }
}

struct ChatView: View {
    
    @State private var message = ""
    
    @ObservedObject var back: NavigationBeetweenChats
    
    var chat_id: Int64?
    @StateObject private var model: ChatViewModel = ChatViewModel()

    private func onAppear() {
        model.chat_id = chat_id!
        model.connect()
        back.Allower = false
    }
    
    private func onCommit() {
        if !message.isEmpty {
            model.sendMessage(message: Message(id: Int64(model.messages.count), chat_id: model.chat_id ?? 0, user_id: USER?.id ?? 0, text: message, attachments: [:], deleted_all: false, deleted_user: false, edited: false))
            message = ""
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(model.messages) { message in
                        MessageView(message: message)
                    }
                }
            }
            HStack {
                TextField("Message", text: $message, onEditingChanged: {_ in}, onCommit: onCommit)
                    .padding(10)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)
                Button(action:onCommit) {
                    Image(systemName: "arrow.turn.up.right")
                        .font(.system(size: 20))
                }
                .padding()
                .disabled(message.isEmpty)
            }
            .padding()
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: {back.toggler.toggle()})
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
            ChatView(back: NavigationBeetweenChats(), chat_id: 2)
    }
}

