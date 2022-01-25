//
//  SocketIOManagerInterface.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 22.01.2022.
//

import Foundation

protocol SocketIOManagerProtocol {
    func establishConnection()
    func closeConnection()
    
    func react_con(completionHandler: @escaping () -> Void)
    func react_users(completionHandler: @escaping (Any) -> Void)
    func recieve_chats(completionHandler: @escaping ([String:Any]) -> Void)
    func recieve_chat_users(completionHandler: @escaping ([Any]) -> Void)
    func recieve_chat_msgs(completionHandler: @escaping ([[String:Any]]) -> Void)
    func observeMessages(completionHandler: @escaping (Message) -> Void)
    
    func get_chat_ids(user_id: Int64)
    func request_chat_data_for_preview(chat_id: Int64)
    func send(message: Message)
    func get_users_from_school_id(school_id: Int64)
    func requestChatMsgs(user_id: Int64, chat_id: Int64)
    func createChat(creator_id: Int64, name: String, users: [User])
    func request_chat_users(chat_id: Int64)
}
