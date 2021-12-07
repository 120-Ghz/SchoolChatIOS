//
//  MessageView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    var body: some View {
        HStack {
            if message.user_id == USER?.id {
                Spacer()
            }
            Text(message.text)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(message.user_id == USER?.id ? Color.blue : Color.gray)
                .foregroundColor(message.user_id == USER?.id ? Color.white : Color.black)
                .cornerRadius(16)
            
            if message.user_id != USER?.id{
                Spacer()
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(id: 5, chat_id: 5, user_id: 5, text: "Я купил сочных булочек", attachments: [:], deleted_all: false, deleted_user: false, edited: false))
    }
}
