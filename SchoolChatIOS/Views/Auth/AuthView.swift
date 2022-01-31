//
//  AuthView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 31.01.2022.
//

import SwiftUI

struct AuthView: View {
    
    @State var SignUp = false
    @StateObject var AuthOb: AuthObj
    
    var HintColor = Color(UIColor(Color(red: 90/255, green: 0, blue: 90/255)).withAlphaComponent(0.7))
    var TextColor = Color(red: 90/255, green: 0, blue: 90/255)
    let screenWidth = UIScreen.main.bounds.size.width
    
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(SignUp ? "Регистрация" : "Авторизация")
                    .font(Font.custom("helvetica", size: 30))
                    .fontWeight(.semibold)
                    .foregroundColor(TextColor)
                    .padding(.bottom, 30)
                    .padding(.top, 50)
                Spacer()
                if SignUp {
                    SignUpView(AuthOb: AuthOb)
                } else {
                    SignInView(AuthO: AuthOb)
                }
                Spacer()
                Spacer()
                HStack {
                    Text("Авторизация")
                        .fontWeight(.semibold)
                        .foregroundColor(SignUp ? HintColor : .white)
                        .padding()
                        .background(Capsule().fill(Color.purple.opacity(SignUp ? 0 : 1)).frame(height: 50))
                        .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(SignUp ? 0 : 0.8)), radius: 8, x: 0, y: 9)
                    Text("Регистрация")
                        .fontWeight(.semibold)
                        .foregroundColor(SignUp ? .white : HintColor)
                        .padding()
                        .background(Capsule().fill(Color.purple.opacity(SignUp ? 1 : 0)).frame(height: 50))
                        .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(SignUp ? 0.8 : 0)), radius: 8, x: 0, y: 9)
                    
                }
                .onTapGesture {
                    withAnimation {
                        SignUp.toggle()
                    }
                }
                .padding()
                .padding(.top, 5)
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [.white, .purple.opacity(0.2), .yellow.opacity(0.7)]), startPoint: .topTrailing, endPoint: .bottomLeading))
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(AuthOb: AuthObj())
    }
}
