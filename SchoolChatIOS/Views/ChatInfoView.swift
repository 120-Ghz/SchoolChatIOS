//
//  ChatInfoView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 23.01.2022.
//

import SwiftUI

struct ChatInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var chat: Chat
    var users: [User]
    
    func onAppear() {
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ChatPicture(chat: chat, frameRadius: 100)
                Spacer()
            }
            Text(chat.name)
                .padding()
            // TODO: Chat members count
            List {
                ForEach(users) { user in
                    UserRow(user: user, selected: false)
                }
            }
        }.onAppear(perform: onAppear)
    }
}

struct ChatInfoView_Previews: PreviewProvider {
    var User1 = User(id: 1, name: "Anton", surname: "Antonov", school_id: 0, class_id: 4, email: "", phone: "", avatar: "")
    static var previews: some View {
        ChatInfoView(chat: Chat(id: 2, name: "Test Chat", creator: 2, picture_url: "", deleted: false, hasLastMsg: true, last_msg_text: "Aboba", last_msg_user: 1, last_msg_time: Date.now, last_msg_username: "", last_msg_userpic: "", admins: [], left: false), users: [])
    }
}
