//
//  SchoolChatIOSApp.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI
import SocketIO

var USER: User? = User(id: 2, name: "", surname: "", school_id: 4, class_id: 4, email: "", phone: "")
var AUTH: Bool = false

var WShost = URL(string: "https://school-chat-server-ws.herokuapp.com")
//var WShost = URL(string: "http://192.168.0.15:3000")

var manager = SocketManager(socketURL: WShost!)
var socket = manager.defaultSocket

@main
struct SchoolChatIOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
