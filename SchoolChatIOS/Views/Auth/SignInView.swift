//
//  SignInView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 17.01.2022.
//

import SwiftUI

final class SignInViewModel: ObservableObject {
    
    var manager = SocketIOManager()
    @Published var AuthStat = false
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
        let data = incoming["data"] as! [String: Any]
        AuthStat = ComparePasswords(hash: data["password"] as! String)
        AUTH = AuthStat
        if AUTH {
            USER = User(id: Int64(data["id"] as! String)!, name: data["name"] as! String, surname: data["surname"] as! String, school_id: Int64(data["school_id"] as! String)!, class_id: Int64(data["class_id"] as! String)!, email: data["email"] as! String, phone: data["phone"] as! String, avatar: data["picture_url"] as? String ?? "")
        }
    }
    
    func send_data(data: String) {
        manager.SendAuthData(data: data)
    }
}

struct SignInView: View {
    
    @StateObject var model: SignInViewModel = SignInViewModel()
    @State var login: String = ""
    @State var password: String = ""
    
    func onCommit() {
        model.create(data: login.lowercased(), UserInput: password)
    }
    
    var body: some View {
        VStack {
            if model.AuthStat {
                MessengerView()
            } else {
                TextField("Login", text: $login, onCommit: onCommit)
                    .padding(10)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(20)
                TextField("Password", text: $password, onCommit: onCommit)
                    .padding(10)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(20)
                Button("PressMe") {
                    onCommit()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
