//
//  NewChatViewModel.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 09.02.2022.
//

import Foundation

final class NewChatViewModel: ObservableObject {
    
    @Published var FilteredUsers: [User] = []
    @Published var UsersToSend: [User] = []
    
    
    let manager = SocketIOManager()
    
    func create() {
        manager.react_users(completionHandler: getSchoolUsers)
    }
    
    func requestSchoolUsers(school_id: Int64) {
        manager.get_users_from_school_id(school_id: school_id)
    }
    
    func getSchoolUsers(inc: Any) {
        //        let Users = incoming as! [String: Any]
        if ((inc as! [String: Any])["stat"] as! String) != "OK" {
            return
        }
        let incoming = (inc as! [String: Any])["data"]
        let Users = incoming as! [[String: Any]]
        var counter = 0
        for user in Users {
            //            print(user)
            counter += 1
            FilteredUsers.append(User(id: Int64(user["id"] as! String)!, name: user["name"] as! String, surname: user["surname"] as! String, school_id: Int64(user["school_id"] as! String)!, class_id: Int64(user["class_id"] as! String)!, email: user["email"] as! String, phone: user["phone"] as! String, avatar: "picture_url"))
        }
    }
    
    func createChat(creator_id: Int64, name: String) {
        manager.createChat(creator_id: creator_id, name: name, users: UsersToSend)
    }
    
}
