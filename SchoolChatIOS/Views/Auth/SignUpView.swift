//
//  SignUpView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 17.01.2022.
//

import SwiftUI

struct SignUpView: View {
    @State var surname: String = ""
    @State var name: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var password: String = ""
    @State var password_confirmation: String = ""
    @State var invite_code: String = ""
    @State var ShowPassword: Bool = false
    @State var ShowPasswordConfirmation: Bool = false
    @State var ComparePassword: Bool = false
    @State var ShouldShowConfirmation: Bool = false
    @State var RedName: Bool = false
    @State var RedSurname: Bool = false
    @State var RedEmail: Bool = false
    @State var RedPhone: Bool = false
    @State var RedInviteCode: Bool = false
    @State var RedPassword: Bool = false
    @StateObject var model: SignUpViewModel = SignUpViewModel()
    @ObservedObject var AuthOb: AuthObj
    
    var TextColor = Color("TextColor")
    var HintColor = Color("HintColor")
    
    func onCommit() {
        var ret = false
        if name.isEmpty {
            RedName = true
            ret = true
        } else {
            RedName = false
        }
        if surname.isEmpty {
            RedSurname = true
            ret = true
        } else {
            RedSurname = false
        }
        if email.isEmpty {
            RedEmail = true
            ret = true
        } else {
            RedEmail = false
        }
        if phone.isEmpty {
            RedPhone = true
            ret = true
        } else {
            RedPhone = false
        }
        if invite_code.isEmpty {
            RedInviteCode = true
            ret = true
        } else {
            RedInviteCode = false
        }
        if password.isEmpty {
            RedPassword = true
            ret = true
        } else {
            RedPassword = false
        }
        if !ComparePassword {
            return
        }
        if ret {
            return
        }
        let hashed_password = CryptManagerWrapper().hashPassword(password)
        model.create(data: ["name": name, "surname": surname, "email": email, "phone": phone, "password": hashed_password!, "invite_code": invite_code])
    }
    
    var Shadow: some View {
        return Capsule().fill(.white).frame(height: 50)
            .shadow(color: Color(UIColor(TextColor).withAlphaComponent(0.1)), radius: 2, x: 0, y: 3)
    }
    
    var body: some View {
        
        VStack{
            ZStack {
                VStack(spacing: 0.0) {
                    ZStack {
                        VStack(spacing: 5) {
                            ZStack{
                                Shadow
                                if RedSurname {
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
                                    TextField("", text: $surname)
                                        .font(Font.body.weight(.semibold))
                                        .foregroundColor(TextColor)
                                        .placeholder(when: surname.isEmpty) {
                                            Text("Фамилия").foregroundColor(HintColor).fontWeight(.semibold)
                                        }
                                }
                                .padding()
                                .padding(.top, 0)
                            }
                            
                            ZStack{
                                Shadow
                                if RedName {
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
                                    TextField("", text: $name)
                                        .font(Font.body.weight(.semibold))
                                        .foregroundColor(TextColor)
                                        .placeholder(when: name.isEmpty) {
                                            Text("Имя").foregroundColor(HintColor).fontWeight(.semibold)
                                        }
                                }
                                .padding()
                                .padding(.top, 0)
                            }
                            
                            ZStack{
                                Shadow
                                if RedEmail {
                                    Capsule().fill(Color.red.opacity(0.3))
                                        .frame(height: 50)
                                } else {
                                    Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                        .frame(height: 50)
                                }
                                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.semibold))
                                    TextField("", text: $email)
                                        .font(Font.body.weight(.semibold))
                                        .foregroundColor(TextColor)
                                        .placeholder(when: email.isEmpty) {
                                            Text("Эл. почта").foregroundColor(HintColor).fontWeight(.semibold)
                                        }
                                }
                                .padding()
                                .padding(.top, 0)
                            }
                            
                            ZStack{
                                Shadow
                                if RedPhone {
                                    Capsule().fill(Color.red.opacity(0.3))
                                        .frame(height: 50)
                                } else {
                                    Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                        .frame(height: 50)
                                }
                                HStack {
                                    Image(systemName: "phone")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.semibold))
                                    TextField("", text: $phone)
                                        .font(Font.body.weight(.semibold))
                                        .foregroundColor(TextColor)
                                        .placeholder(when: phone.isEmpty) {
                                            Text("Номер телефона").foregroundColor(HintColor).fontWeight(.semibold)
                                        }
                                }
                                .padding()
                                .padding(.top, 0)
                            }
                            
                            ZStack{
                                Shadow
                                if ShouldShowConfirmation {
                                    Capsule().fill( ComparePassword ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                                        .frame(height: 50)
                                } else {
                                    if RedPassword {
                                        Capsule().fill(Color.red.opacity(0.3))
                                            .frame(height: 50)
                                    } else {
                                        Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                            .frame(height: 50)
                                    }
                                }
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.semibold))
                                    if ShowPassword {
                                        TextField("", text: $password)
                                            .font(Font.body.weight(.semibold))
                                            .foregroundColor(TextColor)
                                            .frame(height: 20)
                                            .placeholder(when: password.isEmpty) {
                                                Text("Пароль").foregroundColor(HintColor).fontWeight(.semibold)
                                            }
                                    } else {
                                        SecureField("", text: $password)
                                            .font(Font.body.weight(.semibold))
                                            .foregroundColor(TextColor)
                                            .frame(height: 20)
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
                                .padding(.top, 0)
                            }
                            
                            if ShouldShowConfirmation {
                                ZStack{
                                    Shadow
                                    Capsule().fill( ComparePassword ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                                        .frame(height: 50)
                                    HStack {
                                        Image(systemName: "lock")
                                            .foregroundColor(TextColor)
                                            .font(Font.body.weight(.semibold))
                                        if ShowPasswordConfirmation {
                                            TextField("", text: $password_confirmation)
                                                .font(Font.body.weight(.semibold))
                                                .foregroundColor(TextColor)
                                                .frame(height: 20)
                                                .placeholder(when: password_confirmation.isEmpty) {
                                                    Text("Подтверждение пароля").foregroundColor(HintColor).fontWeight(.semibold)
                                                }
                                        } else {
                                            SecureField("", text: $password_confirmation)
                                                .font(Font.body.weight(.semibold))
                                                .foregroundColor(TextColor)
                                                .frame(height: 20)
                                                .placeholder(when: password_confirmation.isEmpty) {
                                                    Text("Подтверждение пароля").foregroundColor(HintColor).fontWeight(.semibold)
                                                }
                                        }
                                        if !password_confirmation.isEmpty {
                                            Button(action: { self.ShowPasswordConfirmation.toggle()}) {
                                                Image(systemName: "eye")
                                                    .foregroundColor(TextColor)
                                                    .font(Font.body.weight(.bold))
                                            }
                                        }
                                    }
                                    .padding()
                                    .padding(.top, 0)
                                }
                                
                            }
                            ZStack{
                                Shadow
                                if RedInviteCode {
                                    Capsule().fill(Color.red.opacity(0.3))
                                        .frame(height: 50)
                                } else {
                                    Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                        .frame(height: 50)
                                }
                                HStack {
                                    Image(systemName: "person.text.rectangle")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.semibold))
                                    TextField("", text: $invite_code)
                                        .font(Font.body.weight(.semibold))
                                        .foregroundColor(TextColor)
                                        .placeholder(when: invite_code.isEmpty) {
                                            Text("Код приглашения").foregroundColor(HintColor).fontWeight(.semibold)
                                        }
                                }
                                .padding()
                                .padding(.top, 0)
                            }
                            .padding(.bottom, 20)
                        }
                        .padding(.horizontal, 40)
                    }
                    
                    Button(action: onCommit) {
                            Text("Зарегистрироваться")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Capsule().fill(Color.purple).frame(height: 50))
                                .padding(.horizontal)
                        
                    }
                    .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(0.8)), radius: 8, x: 0, y: 9)
                    
                    if (!ShouldShowConfirmation) {
                        Capsule().strokeBorder(Color.black.opacity(0), lineWidth: 0.001)
                            .frame(height: 50).padding(.bottom, 7.4).padding(.top, 0)
                    }
                    
                }
            }
            .onChange(of: model.AuthStat, perform: {stat in
                AuthOb.Auth = stat
            })
            .onChange(of: model.CorrectCode, perform: {stat in
                withAnimation{
                    RedInviteCode = true
                }
            })
            .onChange(of: password, perform: {val in
                withAnimation {
                    ComparePassword = val == password_confirmation
                }
            })
            .onChange(of: password_confirmation, perform: { val in
                withAnimation {
                    ComparePassword = val == password
                }
            })
            .onChange(of: password.isEmpty, perform: { stat in
                withAnimation {
                    ShouldShowConfirmation.toggle()
                }
                if stat {
                    ShowPassword = false
                    password_confirmation = ""
                }
            })
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(AuthOb: AuthObj())
    }
}
