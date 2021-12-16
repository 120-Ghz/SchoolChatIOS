//
//  Models.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import Foundation
import SwiftUI

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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
