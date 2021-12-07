//
//  SocketIOManager.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import Foundation
import SocketIO

class SocketIOManagerDefault: NSObject {
    
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    
    
    override init() {
        super.init()
        
        manager = SocketManager(socketURL: URL(string: "http://192.168.0.13:3000")!)
        socket = manager.defaultSocket
    }
    
    // Connect and Disconnect
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    // recieving data from server
    
    func react_con(completionHandler: @escaping () -> Void) {
        socket.on("connected") { _, ack in
            print("conn")
            completionHandler()
        }
    }
    
    func react_chats(complete: @escaping (NSArray) -> Void) {
        socket.on("recieve-chats") { (data, ack) in
            guard let chats = data[0] as? [String:Any] else {return}
            let ch = chats["res"] as! NSArray
            complete(ch)
        }
    }
    
    func recieve_chats(complete: @escaping ([String:Any]) -> Void){
        socket.on("chat_preview_info") { (data, ack) in
            print(data)
        }
    }
    
    func observeMessages(completionHandler: @escaping (Message) -> Void) {
        socket.on("msg") { (dataArray, ack) in
            guard let data = dataArray[0] as? [String: Any] else {return}
            print(dataArray[0])
            var msg = Message(id: data["id"] as! Int64, chat_id: data["chat_id"] as! Int64, user_id: data["user_id"] as! Int64, text: data["text"] as! String, attachments: data["attachments"] as! [String: Any], deleted_all: data["deleted_all"] as! Bool, deleted_user: data["deleted_user"] as! Bool, edited: data["edited"] as! Bool)
            completionHandler(msg)
        }
    }
    
    // Requests
    
    func get_chat_ids(user_id: Int64){
        print("in func")
        socket.emit("chats", ["user_id": 5])
        print("emited")
    }
    
    func request_chat_data(chat_id: Int64){
        socket.emit("get-info", ["flag":"chat", "data":["chat_id": chat_id]])
    }
    
    func send(message: Message) {
        socket.emit("newMessage", ["user_id": message.user_id, "id": message.id, "chat_id": message.chat_id, "text": message.text, "attachments": message.attachments, "deleted_all": message.deleted_all, "deleted_user": message.deleted_user, "edited": message.edited])
    }
}

