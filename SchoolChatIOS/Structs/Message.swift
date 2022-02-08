//
//  Message.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 08.02.2022.
//

import Foundation

struct Message: Identifiable {
    var InternalId = UUID()
    var id: Int64
    var chat_id: Int64
    var user_id: Int64
    var text: String
    var attachments: [String: Any]
    var deleted_all: Bool
    var deleted_user: Bool
    var edited: Bool
    var time: Date
    var service: Bool
    var user_name: String
    var user_pic: String
}
