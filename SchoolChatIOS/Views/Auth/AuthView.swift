//
//  AuthView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 13.01.2022.
//

import SwiftUI


struct AuthView: View {

    func SignUpButton() -> some View {
        NavigationLink(destination: SignUpView()) {
            Text("Sign Up")
        }
    }
    
    func SignInButton() -> some View {
        NavigationLink(destination: SignInView()) {
            Text("Sign In")
        }
    }
    
    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                SignInButton()
                Spacer()
                SignUpButton()
                Spacer()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
