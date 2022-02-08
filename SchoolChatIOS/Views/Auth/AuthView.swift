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
    @State private var Messenger = false
    
    var HintColor = Color(UIColor(Color(red: 90/255, green: 0, blue: 90/255)).withAlphaComponent(0.7))
    var TextColor = Color(red: 90/255, green: 0, blue: 90/255)
    let screenWidth = UIScreen.main.bounds.size.width
    
    var defaultHeight = 844.0
    var defaultWidth = 390.0
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    VStack {
                        ZStack {
                            NavigationLink("Messenger", destination: MessengerView(), isActive: $Messenger)
                                .opacity(0)
                            VStack {
                                Spacer()
                                Text(SignUp ? "Регистрация" : "Авторизация")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(TextColor)
                                    .padding(.top, 20)
                                
                                Spacer()
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
                                        .frame(maxWidth: .infinity)
                                        .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(SignUp ? 0 : 0.8)), radius: 8, x: 0, y: 9)
                                        .padding(.leading)
                                    Text("Регистрация")
                                        .fontWeight(.semibold)
                                        .foregroundColor(SignUp ? .white : HintColor)
                                        .padding()
                                        .background(Capsule().fill( SignUp ?  Color.purple.opacity(SignUp ? 1 : 0) : Color.white).frame(height: 50))
                                        .frame(maxWidth: .infinity)
                                        .shadow(color: Color(UIColor(Color.purple).withAlphaComponent(SignUp ? 0.8 : 0)), radius: 8, x: 0, y: 9)
                                        .padding(.trailing)
                                    
                                }
                                .onTapGesture {
                                    withAnimation {
                                        SignUp.toggle()
                                    }
                                }
                                .padding()
                                .padding(.top, 0)
                                .padding(.bottom)
                            }
                        }
                    }
                    .padding(.bottom, 4)
                }
                .onChange(of: AuthOb.Auth, perform: {stat in
                    print(stat)
                    Messenger = stat
                })
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .background(LinearGradient(gradient: Gradient(colors: [.white, .purple.opacity(0.2), .cyan.opacity(0.5)]), startPoint: .topTrailing, endPoint: .bottomLeading))
                
            }
        }
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(AuthOb: AuthObj())
    }
}
