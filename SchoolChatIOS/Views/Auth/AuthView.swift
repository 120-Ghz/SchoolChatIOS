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
    
    var defaultHeight = 844.0
    var defaultWidth = 390.0
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    VStack {
                        Spacer()
                        Text(SignUp ? "Регистрация" : "Авторизация")
                            .font(Font.custom("helvetica", size: 30))
                            .fontWeight(.semibold)
                            .foregroundColor(TextColor)
                            .padding()
                            
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
                                .background(Capsule().fill(SignUp ? Color.white : Color.purple.opacity(SignUp ? 0 : 1)).frame(height: 50))
                                .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(SignUp ? 0 : 0.8)), radius: 8, x: 0, y: 9)
                            Text("Регистрация")
                                .fontWeight(.semibold)
                                .foregroundColor(SignUp ? .white : HintColor)
                                .padding()
                                .background(Capsule().fill( SignUp ?  Color.purple.opacity(SignUp ? 1 : 0) : Color.white).frame(height: 50))
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
            }
            .padding(.bottom, 4)
            .scaleEffect( UIScreen.main.bounds.height < defaultHeight ? UIScreen.main.bounds.height/(defaultHeight*0.9) : 1)
            .onAppear(perform: {
                print(UIScreen.main.bounds.width)
            })
        }
        .background(LinearGradient(gradient: Gradient(colors: [.white, .purple.opacity(0.2), .yellow.opacity(0.7)]), startPoint: .topTrailing, endPoint: .bottomLeading))
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(AuthOb: AuthObj())
    }
}
