//
//  Models.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import Foundation

struct Message: Identifiable {
    let id: Int64
    let chat_id: Int64
    let user_id: Int64
    let text: String
    let attachments: [String: Any]
    let deleted_all: Bool
    let deleted_user: Bool
    let edited: Bool
}

struct User {
    let id: Int64
    let name: String
    let surname: String
    let school_id: Int64
    let class_id: Int64
    let email: String
    let phone: String
}

struct Chat: Identifiable {
    let id: Int64
    let name: String
    let creator: Int64
    let picture_url: String
    let deleted: Bool
    let last_msg_text: String
    let last_msg_user: Int64
    let last_msg_time: String
}

