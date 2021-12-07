//
//  SchoolChatIOSApp.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

var USER: User? = User(id: 7, name: "", surname: "", school_id: 4, class_id: 4, email: "", phone: "")
var AUTH: Bool = false

@main
struct SchoolChatIOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
