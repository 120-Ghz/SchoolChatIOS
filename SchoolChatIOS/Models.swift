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

struct User: Identifiable, Equatable {
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

struct Chat: Identifiable, Equatable {
    static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.creator == rhs.creator && lhs.picture_url == rhs.picture_url && lhs.deleted == rhs.deleted && lhs.hasLastMsg == rhs.hasLastMsg && lhs.last_msg_text == rhs.last_msg_text && lhs.last_msg_user == rhs.last_msg_user && lhs.last_msg_time == rhs.last_msg_time && lhs.last_msg_username == rhs.last_msg_username && lhs.admins == rhs.admins && lhs.left == rhs.left
    }
    
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
    let admins: [Int64]
    let left: Bool
    let users: [[String: Any]]
}
