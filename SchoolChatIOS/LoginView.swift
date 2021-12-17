//
//  LoginView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

struct FormattedTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(red: 100, green: 100, blue: 0))
            .clipShape(Capsule())
            .padding()
    }
}

struct LoginView: View {
    @State private var status: Bool? = nil
    @State private var reg: Bool? = nil
    @State private var login: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack {
                    TextField("login", text: $login)
                        .textFieldStyle(FormattedTextField())
                    TextField("pswd", text: $password)
                        .padding()
                        .background(Color(red: 100, green: 100, blue: 0))
                        .clipShape(Capsule())
                        .padding()
                }
                HStack {
                    Spacer()
                    NavigationLink(destination: ChatView(back: NavigationBeetweenChats(), chat_id: 5), tag: true, selection: $status) { EmptyView() }
                    Button("Login") {
                        auth()
                    }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.5))
                        .clipShape(Capsule())
                    Spacer()
                    NavigationLink(destination: Text("reg"), tag: true, selection: $reg) { EmptyView() }
                    Button("Register") {
                        self.reg = true
                    }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.5))
                        .clipShape(Capsule())
                    Spacer()
                }
            }.navigationTitle("Auth")
        }
    }
    
    func auth() {
        AUTH = true
        self.status = true
    }
    
    func CreateUserData(){
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

