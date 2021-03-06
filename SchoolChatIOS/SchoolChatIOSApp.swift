//
//  SchoolChatIOSApp.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI
import SocketIO

var USER: User?

var WShost = URL(string: "https://school-chat-server-ws.herokuapp.com")
//var WShost = URL(string: "http://192.168.0.12:3000")
//var WShost = URL(string: "http://localhost:3000")

var manager = SocketManager(socketURL: WShost!, config: [.version(.three)])
var socket = manager.defaultSocket


@main
struct SchoolChatIOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
