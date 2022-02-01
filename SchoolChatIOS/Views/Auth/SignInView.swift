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
        if AuthStat {
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
    @State var ShowPassword: Bool = false
    @State var RedLogin: Bool = false
    @State var RedPassword: Bool = false
    @ObservedObject var AuthO: AuthObj
    
    var TextColor = Color(red: 90/255, green: 0, blue: 90/255)
    var BGColor = Color(red: 164/255, green: 65/255, blue: 171/255)
    var HintColor = Color(UIColor(Color(red: 90/255, green: 0, blue: 90/255)).withAlphaComponent(0.7))
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    func onCommit() {
        var ret = false
        if (login.isEmpty) {
            RedLogin = true
            ret = true
        } else {
            RedLogin = false
        }
        if (password.isEmpty) {
            RedPassword = true
            ret = true
        } else {
            RedPassword = false
        }
        if ret {
            return
        }
        print(screenWidth)
        model.create(data: login.lowercased(), UserInput: password)
    }
    
    var Shadow: some View {
        return Capsule().fill(.white).frame(height: 50)
            .shadow(color: Color(UIColor(TextColor).withAlphaComponent(0.1)), radius: 2, x: 0, y: 3)
    }
    
    var body: some View {
        VStack {
            //                Text("Sign In")
            //                    .font(Font.custom("helvetica", size: 30))
            //                    .fontWeight(.semibold)
            //                    .foregroundColor(TextColor)
            //                    .padding(.bottom, 70)
            
            ZStack {
                VStack {
                    ZStack{
                        Shadow
                        if RedLogin {
                            Capsule().fill(Color.red.opacity(0.3))
                                .frame(height: 50)
                        } else {
                        Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                            .frame(height: 50)
                        }
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(TextColor)
                                .font(Font.body.weight(.semibold))
                            TextField("", text: $login)
                                .foregroundColor(TextColor)
                                .font(Font.body.weight(.semibold))
                                .placeholder(when: login.isEmpty) {
                                    Text("Эл. почта или телефон").foregroundColor(HintColor).fontWeight(.semibold)
                                        .lineLimit(1)
                                }
                        }
                        .padding()
                    }
                    .padding(.bottom, 5)
                    ZStack{
                        Shadow
                        if RedPassword {
                            Capsule().fill(Color.red.opacity(0.3))
                                .frame(height: 50)
                        } else {
                        Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                            .frame(height: 50)
                        }
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(TextColor)
                                .font(Font.body.weight(.semibold))
                            if ShowPassword {
                                TextField("", text: $password)
                                    .frame(height: 20)
                                    .foregroundColor(TextColor)
                                    .font(Font.body.weight(.semibold))
                                    .placeholder(when: password.isEmpty) {
                                        Text("Пароль").foregroundColor(TextColor)
                                            .fontWeight(.semibold)
                                    }
                            } else {
                                SecureField("", text: $password)
                                    .frame(height: 20)
                                    .foregroundColor(TextColor)
                                    .font(Font.body.weight(.semibold))
                                    .placeholder(when: password.isEmpty) {
                                        Text("Пароль").foregroundColor(HintColor).fontWeight(.semibold)
                                    }
                            }
                            if !password.isEmpty {
                                Button(action: { self.ShowPassword.toggle()}) {
                                    Image(systemName: "eye")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.bold))
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 40)
            }
            HStack{
                Button(action: onCommit) {
                    Text("Войти")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .background(Capsule().fill(Color.purple).frame(width: screenWidth/2.7, height: 50))
                .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(0.8)), radius: 8, x: 0, y: 9)
                .padding(.top)
                
            }
            .padding(.vertical, 0)
            //                HStack {
            //                    Button(action: {
            //                        withAnimation {
            //                        navigator.SignUp.toggle()
            //                        }
            //                    }) {
            //                        Text("Sign Up")
            //                            .fontWeight(.semibold)
            //                            .foregroundColor(HintColor)
            //                    }
            //                    .background(Capsule().fill(Color.white.opacity(0.8)).frame(width: screenWidth/2.7, height: 50))
            //                    .shadow(color: Color(UIColor(Color.white.opacity(0.8)).withAlphaComponent(0.8)), radius: 8, x: 0, y: 9)
            //                    .padding()
            //                }
        }
        .onChange(of: model.AuthStat, perform: {stat in
            AuthO.Auth = stat
        })
        .onChange(of: password.isEmpty, perform: { stat in
            if stat {
                ShowPassword = false
            }
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(AuthO: AuthObj())
    }
}
