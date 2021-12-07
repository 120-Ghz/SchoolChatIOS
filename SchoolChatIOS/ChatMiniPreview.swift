//
//  ChatMiniPreview.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

struct ChatMiniPreview: View {
    let chat: Chat
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 70, height: 70)
                    }.padding()
                    VStack{
                        Text(chat.name)
                            .padding()
                            .font(.system(size: 27))
                            .font(Font.headline.weight(.heavy))
                        Text(chat.last_msg_text)
                            .padding()
                    }
                    Spacer()
                }
            }
        }
        .background(Color.gray)
        .cornerRadius(50)
    }
}

struct ChatMiniPreview_Previews: PreviewProvider {
    static var previews: some View {
        ChatMiniPreview(chat: Chat(id: 5, name: "aboba", creator: 16, picture_url: "  ", deleted: false, last_msg_text: "Тестовое сообщение", last_msg_user: 5, last_msg_time: "12"))
    }
}
