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
                            .padding(.bottom, 6)
                            .font(.system(size: 27))
                            .font(Font.headline.weight(.heavy))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                            .foregroundColor(Color.red)
                        Text(chat.last_msg_text == "" ? " ":chat.last_msg_text)
                            //.padding(.bottom, 20)
                            //.padding(.top, 2)
                            .foregroundColor(Color.cyan)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)
                    }
                    .padding(.bottom, 20)
                    .padding(.top, 20)
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
        ChatMiniPreview(chat: Chat(id: 5, name: "aaa", creator: 16, picture_url: "  ", deleted: false, last_msg_text: "Тестовое сообщение", last_msg_user: 5, last_msg_time: "12"))
    }
}
