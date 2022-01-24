//
//  MessageView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var DefaultMessage: some View {
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
            
            if message.user_id != USER?.id {
                Spacer()
            }
        }
    }
    
    var ServiceMessage: some View {
        HStack {
            Spacer()
            Text(message.text)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 4)
                .padding()
                .foregroundColor(.black)
                .background(Color.green)
                .cornerRadius(16)
            Spacer()
        }
    }
    
    var body: some View {
        if message.service {
            ServiceMessage
        } else {
            DefaultMessage
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(id: 5, chat_id: 1, user_id: 2, text: "Я купил сочных булочек", attachments: [:], deleted_all: false, deleted_user: false, edited: false, time: Date.now, service: true))
    }
}
