//
//  ChatPicture.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 26.12.2021.
//

import SwiftUI

struct ChatPicture: View {
    let chat: Chat
    let frameRadius: CGFloat
    
    func check_is_digit(data: String) -> Bool {
        guard Int(data) != nil else {return false}
        return true
    }
    
    func PicText() -> String {
        var res = ""
        if check_is_digit(data: String(chat.name.prefix(2))) {
            return chat.name.prefix(2) + (chat.name.split_by_space().count > 1 ? chat.name.split_by_space()[1].prefix(1).uppercased() : "")
        }
        var counter = 0
        for word in chat.name.split_by_space() {
            if counter >= 2 { break }
            res += word.prefix(1).uppercased()
            counter += 1
        }
        return res
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: frameRadius, height: frameRadius)
                
                if chat.picture_url.space_deleter() == "" {
                    Text(PicText())
                        .font(.system(size: frameRadius/2))
                        .foregroundColor(Color.white)
                } else {
                    Image(chat.picture_url)
                }
                
            }
        }
    }
}

struct ChatPicture_Previews: PreviewProvider {
    static var previews: some View {
        ChatPicture(chat: Chat(id: 5, name: "11Б Инженерный", creator: 16, picture_url: "", deleted: false, hasLastMsg: true, last_msg_text: "Тестовое сообщение", last_msg_user: 5, last_msg_time: Date.now, last_msg_username: "", admins: []), frameRadius: 70)
    }
}
