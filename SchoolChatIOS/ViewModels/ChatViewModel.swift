//
//  ChatViewModel.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 09.02.2022.
//

import Foundation
import SwiftUI

final class ChatViewModel: ObservableObject {
    
    @Published private(set) var messages: [Message] = []
    @Published var scroll = false
    @Published var Users: [User] = []
    
    var chat_id: Int64 = 0
    var manager = SocketIOManager()
    
    func connect() {
        manager.observeMessages(completionHandler: NewMsg)
        manager.recieve_chat_msgs(completionHandler: getMessages)
        manager.recieve_chat_users(completionHandler: get_users)
        manager.message_deleted(completionHandler: deletedMessageHandler)
        manager.message_edited(completionHandler: editedMessageHandler)
        request_users()
    }
    
    func deletedMessageHandler(incoming: [String: Any]) {
        if (incoming["stat"] as? String ?? "" != "OK") {
            return
        }
        guard let data = incoming["data"] as? [String: Any] else {return}
        guard let id = data["id"] as? Int64 else {return}
        let index = get_msg_index_by_id(id: id)
        if index == -1 {
            return
        }
        messages.remove(at: index)
    }
    
    func editedMessageHandler(incoming: [String: Any]) {
        if (incoming["stat"] as? String ?? "" != "OK") {
            return
        }
        guard let data = incoming["data"] as? [String: Any] else {return}
        let id = Int64(data["id"] as? String ?? "") ?? 0
        let index = get_msg_index_by_id(id: id)
        if index == -1 {
            return
        }
        withAnimation {
            messages[index].edited = true
            messages[index].attachments = data["attachments"] as? [String: Any] ?? [:]
            messages[index].text = data["text"] as? String ?? messages[index].text
            messages[index].time = (data["updatedAt"] as? String ?? "").JSDateToDate()
        }
    }
    
    func request_users() {
        manager.request_chat_users(chat_id: chat_id)
    }
    
    func get_users(incoming: [Any]) {
        for raw in incoming {
            var r = raw as! [Any]
            if (r.count == 0) {
                continue
            }
            guard let data = r[0] as? [String: Any] else {continue}
            let user = User(id: Int64(data["id"] as? String ?? "") ?? 0, name: data["name"] as? String ?? "", surname: data["surname"] as? String ?? "", school_id: Int64(data["school_id"] as? String ?? "") ?? 0, class_id: Int64(data["class_id"] as? String ?? "") ?? 0, email: data["email"] as? String ?? "", phone: data["phone"] as? String ?? "", avatar: data["picture_url"] as? String ?? "")
            if (!Users.contains(user)) {
                Users.append(user)
            }
        }
    }
    private func NewMsg(incoming: Message) {
        if (incoming.chat_id == chat_id) && (!incoming.deleted_all) {
            if get_msg_index_by_id(id: incoming.id) != -1 {
                print("bug")
                return
            }
            messages.append(incoming)
            messages = messages.sorted { return $0.id < $1.id }
            scroll.toggle()
        }
    }
    
    func sendMessage(message: Message) {
        manager.send(user_id: message.user_id, chat_id: message.chat_id, text: message.text, attachments: message.attachments)
    }
    
    private func get_msg_index_by_id(id: Int64) -> Int {
        if messages.count == 0 { return -1 }
        for i in 0...messages.count-1 {
            if messages[i].id == id  {
                return i
                
            }
        }
        return -1
    }
    
    func getMessages(incoming: [String:Any]) {
        if (incoming["stat"] as! String) != "OK" {
            return
        }
        
        let msg = incoming["data"] as! [String: Any]
        if get_msg_index_by_id(id: Int64(msg["id"] as! String)!)  != -1 {
            return
        }
        messages.append(Message(id: Int64(msg["id"] as? String ?? "") ?? 0, chat_id: Int64(msg["chat_id"] as? String ?? "") ?? 0, user_id: Int64(msg["user_id"] as? String ?? "") ?? 0, text: msg["text"] as? String ?? "", attachments: msg["attachments"] as? [String:Any] ?? [:], deleted_all: msg["deleted_all"] as? Bool ?? false, deleted_user: msg["deleted_user"] as? Bool ?? false, edited: msg["edited"] as? Bool ?? false, time: (msg["createdAt"] as? String ?? "").JSDateToDate(), service: msg["service"] as? Bool ?? false, user_name: msg["user_name"] as? String ?? "", user_pic: msg["user_pic_url"] as? String ?? ""))
        messages = messages.sorted { return $0.id < $1.id }
        scroll.toggle()
    }
    
    func requestMessages() {
        manager.requestChatMsgs(user_id: USER!.id, chat_id: chat_id)
    }
    
    func delete_message_for_all(id: Int64) {
        manager.delete_msg_for_all(id: id)
    }
    
    func delete_message_for_user(id: Int64) {
        manager.delete_msg_for_user(id: id)
    }
    
    func edit_message(id: Int64, text: String) {
        manager.edit_msg(id: id, text: text)
    }
}
