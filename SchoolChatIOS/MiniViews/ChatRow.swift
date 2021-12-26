//
//  ChatMiniPreview.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

struct ChatRow: View {
    let chat: Chat
    var body: some View {
        HStack(spacing: 20) {
            
            ChatPicture(chat: chat)
                .padding()
            
            ZStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(chat.name)
                            .bold()
                        
                        Spacer()
                        
                        Text((chat.last_msg_time.FormatToChatRow()) ?? "")
                            .padding(.horizontal, 8)
                    }
                    
                    HStack {
                        Text(chat.last_msg_text)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing, 40)
                    }
                }
            }
        }
        .frame(height: 80)
    }
}

struct ChatMiniPreview_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chat: Chat(id: 5, name: "aaa", creator: 16, picture_url: "  ", deleted: false, last_msg_text: "Тестовое сообщение", last_msg_user: 5, last_msg_time: "December"))
    }
}
