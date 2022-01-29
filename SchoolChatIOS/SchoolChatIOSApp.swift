//
//  SchoolChatIOSApp.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI
import SocketIO

var USER: User? = User(id: 2, name: "Konstantin", surname: "Leonov", school_id: 4, class_id: 4, email: "aboba@aboba.com", phone: "88005553535", avatar: "")
var AUTH: Bool = false

var WShost = URL(string: "https://school-chat-server-ws.herokuapp.com")
//var WShost = URL(string: "http://192.168.0.12:3000")
//var WShost = URL(string: "http://localhost:3000")

var manager = SocketManager(socketURL: WShost!, config: [.version(.three)])
var socket = manager.defaultSocket

var LocalManager = LocalDataManager()

@main
struct SchoolChatIOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
