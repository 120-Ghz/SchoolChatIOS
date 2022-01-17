//
//  Models.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import Foundation
import SwiftUI

struct Message: Identifiable {
    let InternalId = UUID()
    let id: Int64
    let chat_id: Int64
    let user_id: Int64
    let text: String
    let attachments: [String: Any]
    let deleted_all: Bool
    let deleted_user: Bool
    let edited: Bool
    let time: Date
    let service: Bool
}

struct User {
    let id: Int64
    let name: String
    let surname: String
    let school_id: Int64
    let class_id: Int64
    let email: String
    let phone: String
    let avatar: String = ""
}

struct MiniUser {
    let id: Int64
    let name: String
    let surname: String
    let school_id: Int64
    let class_id: Int64
    let avatar: String
}

struct Chat: Identifiable {
    let id: Int64
    let name: String
    let creator: Int64
    let picture_url: String
    let deleted: Bool
    let hasLastMsg: Bool
    let last_msg_text: String
    let last_msg_user: Int64
    let last_msg_time: Date
    let last_msg_username: String
}
