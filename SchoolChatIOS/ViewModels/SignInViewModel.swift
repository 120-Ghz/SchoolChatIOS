//
//  SignInViewModel.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 09.02.2022.
//

import Foundation

final class SignInViewModel: ObservableObject {
    
    var manager = SocketIOManager()
    @Published var AuthStat = false
    @Published var WrongPassword = false
    @Published var NoUser = false
    @Published var UserPassword = ""
    
    func create(data: String, UserInput: String) {
        manager.recieve_auth_data(completionHandler: AuthdataHandler)
        manager.react_con {
            self.send_data(data: data)
        }
        UserPassword = UserInput
        socket.connect()
    }
    
    func ComparePasswords(hash: String) -> Bool {
        return CryptManagerWrapper().comparePassword(hash, UserPassword)
    }
    
    func AuthdataHandler(incoming: [String: Any]) {
        print(incoming)
        
        if (incoming["stat"] as! String) != "OK" {
            NoUser = true
        }
        
        let data = incoming["data"] as! [String: Any]
        var stat = ComparePasswords(hash: data["password"] as! String)
        if stat {
            USER = User(id: Int64(data["id"] as! String)!, name: data["name"] as! String, surname: data["surname"] as! String, school_id: Int64(data["school_id"] as! String)!, class_id: Int64(data["class_id"] as! String)!, email: data["email"] as! String, phone: data["phone"] as! String, avatar: data["picture_url"] as? String ?? "")
            AuthStat = true
        } else {
            WrongPassword = true
        }
    }
    
    func send_data(data: String) {
        manager.SendAuthData(data: data)
    }
}
