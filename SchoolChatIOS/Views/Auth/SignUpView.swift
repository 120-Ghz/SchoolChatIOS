//
//  SignUpView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 17.01.2022.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var phone: String = ""
    @State var password: String = ""
    @State var password_confirmation: String = ""
    @State var invite_code: String = ""
    @State var ShowPassword: Bool = false
    @State var ShowPasswordConfirmation: Bool = false
    
    @State var ShouldShowConfirmation: Bool = false
    
    var TextColor = Color(red: 90/255, green: 0, blue: 90/255)
    var BGColor = Color(red: 164/255, green: 65/255, blue: 171/255)
    var HintColor = Color(UIColor(Color(red: 90/255, green: 0, blue: 90/255)).withAlphaComponent(0.7))
    
    func onCommit() {
        print("Login")
        //        model.create(data: login.lowercased(), UserInput: password)
    }
    
    var Shadow: some View {
        return Capsule().fill(.white).frame(height: 50)
            .shadow(color: Color(UIColor(TextColor).withAlphaComponent(0.1)), radius: 2, x: 0, y: 3)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    Text("Sign Up")
                        .font(Font.custom("helvetica", size: 30))
                        .fontWeight(.semibold)
                        .foregroundColor(TextColor)
                        .padding(.bottom, 70)
                }
                VStack {
                    ZStack {
                        VStack {
                            ZStack{
                                Shadow
                                Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                    .frame(height: 50)
                                HStack {
                                    Image(systemName: "envelope")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.semibold))
                                    TextField("", text: $email)
                                        .font(Font.body.weight(.semibold))
                                        .foregroundColor(TextColor)
                                        .placeholder(when: email.isEmpty) {
                                            Text("Email").foregroundColor(HintColor).fontWeight(.semibold)
                                        }
                                }
                                .padding()
                                .padding(.top, 0)
                            }
                            .padding(.bottom, 5)
                            ZStack{
                                Shadow
                                Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                    .frame(height: 50)
                                HStack {
                                    Image(systemName: "phone")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.semibold))
                                    TextField("", text: $phone)
                                        .font(Font.body.weight(.semibold))
                                        .foregroundColor(TextColor)
                                        .placeholder(when: phone.isEmpty) {
                                            Text("Phone").foregroundColor(HintColor).fontWeight(.semibold)
                                        }
                                }
                                .padding()
                                .padding(.top, 0)
                            }
                            .padding(.bottom, 5)
                            ZStack{
                                Shadow
                                Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                    .frame(height: 50)
                                HStack {
                                    Image(systemName: "lock")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.semibold))
                                    if ShowPassword {
                                        TextField("", text: $password)
                                            .font(Font.body.weight(.semibold))
                                            .foregroundColor(TextColor)
                                            .placeholder(when: password.isEmpty) {
                                                Text("Password").foregroundColor(HintColor).fontWeight(.semibold)
                                            }
                                    } else {
                                        SecureField("", text: $password)
                                            .font(Font.body.weight(.semibold))
                                            .foregroundColor(TextColor)
                                            .placeholder(when: password.isEmpty) {
                                                Text("Password").foregroundColor(HintColor).fontWeight(.semibold)
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
                            .padding(.bottom, 5)
                            if ShouldShowConfirmation {
                                ZStack{
                                    Shadow
                                    Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                        .frame(height: 50)
                                    HStack {
                                        Image(systemName: "lock")
                                            .foregroundColor(TextColor)
                                            .font(Font.body.weight(.semibold))
                                        if ShowPasswordConfirmation {
                                            TextField("", text: $password_confirmation)
                                                .font(Font.body.weight(.semibold))
                                                .foregroundColor(TextColor)
                                                .placeholder(when: password_confirmation.isEmpty) {
                                                    Text("Confirm password").foregroundColor(HintColor).fontWeight(.semibold)
                                                }
                                        } else {
                                            SecureField("", text: $password_confirmation)
                                                .font(Font.body.weight(.semibold))
                                                .foregroundColor(TextColor)
                                                .placeholder(when: password_confirmation.isEmpty) {
                                                    Text("Confirm password").foregroundColor(HintColor).fontWeight(.semibold)
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
                                .padding(.bottom, 5)
                            }
                            ZStack{
                                Shadow
                                Capsule().strokeBorder(Color.black, lineWidth: 0.001)
                                    .frame(height: 50)
                                HStack {
                                    Image(systemName: "person.text.rectangle")
                                        .foregroundColor(TextColor)
                                        .font(Font.body.weight(.semibold))
                                    TextField("", text: $invite_code)
                                        .font(Font.body.weight(.semibold))
                                        .foregroundColor(TextColor)
                                        .placeholder(when: invite_code.isEmpty) {
                                            Text("Invite code").foregroundColor(HintColor).fontWeight(.semibold)
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
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.top, 0)
                    .padding(.bottom, 0)
                    .background(Capsule().fill(Color.purple).frame(width: 150, height: 50))
                    .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(0.8)), radius: 8, x: 0, y: 9)
                    
                    if (!ShouldShowConfirmation) {
                        Capsule().strokeBorder(Color.black.opacity(0), lineWidth: 0.001)
                            .frame(height: 50).padding(.bottom, 7.4).padding(.top, 0)
                    }
                    
                }
                .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                Spacer()
            }
            .onChange(of: password.isEmpty, perform: { stat in
                withAnimation {
                    ShouldShowConfirmation.toggle()
                }
                if stat {
                    ShowPassword = false
                }
            })
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
