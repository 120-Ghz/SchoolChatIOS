//
//  SignInView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 17.01.2022.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var model: SignInViewModel = SignInViewModel()
    @State var login: String = "Test"
    @State var password: String = "aboba"
    @State var ShowPassword: Bool = false
    @State var RedLogin: Bool = false
    @State var RedPassword: Bool = false
    @ObservedObject var AuthO: AuthObj
    
    var TextColor = Color("TextColor")
    var HintColor = Color("HintColor")
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
                    ZStack {
                    Capsule().fill(Color.purple).frame(width: screenWidth/2.7, height: 50)
                    Text("Войти")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(0.8)), radius: 8, x: 0, y: 9)
                .padding(.top)
                
            }

        }
        .onChange(of: model.AuthStat, perform: {stat in
            AuthO.Auth = stat
        })
        .onChange(of: password.isEmpty, perform: { stat in
            if stat {
                ShowPassword = false
            }
        })
        .onChange(of: model.WrongPassword, perform: { stat in
            AuthO.WrongPassword = stat
        })
        .onChange(of: model.NoUser, perform: {stat in
            AuthO.NoUser = stat
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(AuthO: AuthObj())
    }
}
