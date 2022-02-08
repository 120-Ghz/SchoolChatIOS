//
//  User.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 08.02.2022.
//

import Foundation

struct User: Identifiable, Equatable {
    let id: Int64
    let name: String
    let surname: String
    let school_id: Int64
    let class_id: Int64
    let email: String
    let phone: String
    let avatar: String
}
