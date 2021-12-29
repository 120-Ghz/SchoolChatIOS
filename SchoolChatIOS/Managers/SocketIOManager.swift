//
//  SocketIOManager.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    override init() {
        super.init()
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
            completionHandler()
        }
    }
    
    func react_chats(completionHandler: @escaping ([Any]) -> Void) {
        socket.on("recieve-chats") { (data, ack) in
            guard let chats = data[0] as? [String:Any] else {return}
            let ch = chats["res"] as! [Any]
            completionHandler(ch)
        }
    }
    
    func recieve_chats(completionHandler: @escaping ([String:Any]) -> Void){
        socket.on("chat_preview_info") { (data, ack) in
            completionHandler(data[0] as! [String: Any])
        }
    }
    
    func recieve_chat_msgs(completionHandler: @escaping ([[String:Any]]) -> Void){
        socket.on("chat-message-recieve") { (data, ack) in
            completionHandler((data[0] as! [String:Any])["data"] as! [[String:Any]])
        }
    }
    
    func observeMessages(completionHandler: @escaping (Message) -> Void) {
        socket.on("msg") { (dataArray, ack) in
            guard let data = dataArray[0] as? [String: Any] else {return}
            let msg = Message(id: Int64(data["id"] as! String)!, chat_id: data["chat_id"] as! Int64, user_id: data["user_id"] as! Int64, text: data["text"] as! String, attachments: data["attachments"] as! [String: Any], deleted_all: data["deleted_all"] as? Bool ?? false, deleted_user: data["deleted_user"] as? Bool ?? false, edited: data["edited"] as? Bool ?? false, time: (data["time"] as! String).JSDateToDate())
            completionHandler(msg)
        }
    }
    
    func get_chat_ids(user_id: Int64){
        socket.emit("chats", ["user_id": user_id])
    }
    
    func request_chat_data_for_preview(chat_id: Int64){
        socket.emit("get-info", ["flag":"chat-for-preview", "data":["chat_id": chat_id]])
    }
    
    func send(message: Message) {
        socket.emit("newMessage", ["user_id": message.user_id, "id": message.id, "chat_id": message.chat_id, "text": message.text, "attachments": message.attachments, "deleted_all": message.deleted_all, "deleted_user": message.deleted_user, "edited": message.edited])
    }
    
    func requestChatMsgs(user_id: Int64, chat_id: Int64) {
        socket.emit("get-msgs", ["user_id": user_id, "chat_id": chat_id])
    }
}

