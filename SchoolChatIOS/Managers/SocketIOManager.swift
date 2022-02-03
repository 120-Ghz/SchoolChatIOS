//
//  SocketIOManager.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import Foundation
import SocketIO

class SocketIOManager: SocketIOManagerProtocol {
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
    
    func stop_rect_con() {
        socket.off("connected")
    }
    
    func react_register(completionHandler: @escaping ([String: Any]) -> Void) {
        socket.on("register_ans") { data, ack in
            completionHandler(data[0] as! [String: Any])
        }
    }
    
    func react_users(completionHandler: @escaping (Any) -> Void) {
        socket.on("get_users_school") { data, ack in
            let da = data as! [[String: Any]]
            completionHandler(da[0])
        }
    }
    
    func recieve_chats(completionHandler: @escaping ([String:Any]) -> Void){
        socket.on("chat_preview_info") { (data, ack) in
            completionHandler(data[0] as! [String: Any])
        }
    }
    
    func recieve_chat_users(completionHandler: @escaping ([Any]) -> Void) {
        socket.on("recieve-chat-users") { (data, ack) in
            let inc = (data[0] as! [String: Any])["data"] as! [Any]
            completionHandler(inc)
        }
    }
    
    func recieve_chat_msgs(completionHandler: @escaping ([String:Any]) -> Void){
        socket.on("chat-message-recieve") { (data, ack) in
            
            completionHandler(data[0] as! [String:Any])
        }
    }
    
    func recieve_auth_data(completionHandler: @escaping ([String:Any]) -> Void) {
        socket.on("auth-recieve") { (data, ack) in
            let incoming = data[0] as! [String: Any]
            completionHandler(incoming)
        }
    }
    
    func observeMessages(completionHandler: @escaping (Message) -> Void) {
        socket.on("msg") { (dataArray, ack) in
            guard let dat = dataArray[0] as? [String: Any] else {return}
            if (dat["stat"] as! String) != "OK" {
                return
            }
            let data = dat["data"] as! [String: Any]
            
            let msg = Message(id: Int64(data["id"] as? String ?? "") ?? 0, chat_id: data["chat_id"] as? Int64 ?? 0, user_id: data["user_id"] as? Int64 ?? 0, text: data["text"] as? String ?? "", attachments: data["attachments"] as? [String: Any] ?? [:], deleted_all: data["deleted_all"] as? Bool ?? false, deleted_user: data["deleted_user"] as? Bool ?? false, edited: data["edited"] as? Bool ?? false, time: (data["createdAt"] as? String ?? "").JSDateToDate(), service: data["service"] as? Bool ?? false, user_name: data["user_name"] as? String ?? "", user_pic: data["user_pic_url"] as? String ?? "")
            completionHandler(msg)
        }
    }
    
    func get_chat_ids(user_id: Int64){
        socket.emit("chats", ["user_id": user_id])
    }
    
    func request_chat_data_for_preview(chat_id: Int64) {
        socket.emit("chat-for-preview",["chat_id": chat_id, "user_id": USER!.id])
    }
    
    func send(user_id: Int64, chat_id: Int64, text: String, attachments: [String: Any]) {
        socket.emit("newMessage", ["user_id": user_id, "chat_id": chat_id, "text": text, "attachments": attachments ])
    }
    
    func get_users_from_school_id(school_id: Int64) {
        socket.emit("get-users-by-school", ["school_id": school_id])
    }
    
    func requestChatMsgs(user_id: Int64, chat_id: Int64) {
        socket.emit("get-msgs", ["user_id": user_id, "chat_id": chat_id])
    }
    
    func createChat(creator_id: Int64, name: String, users: [User]) {
        var users_ids: [Int64] = []
        for user in users {
            users_ids.append(user.id)
        }
        socket.emit("add-chat", ["name": name, "user_id": creator_id, "users": users_ids])
    }
    
    func request_chat_users(chat_id: Int64) {
        socket.emit("chat-users", ["chat_id": chat_id])
    }
    
    
    func SendAuthData(data: String) {
        socket.emit("auth-data", ["data": data])
    }
    
    func SendRegistrationData(data: [String: Any]) {
        socket.emit("register", data)
    }
}

