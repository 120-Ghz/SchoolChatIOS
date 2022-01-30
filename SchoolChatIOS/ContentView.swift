//
//  ContentView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI
import SocketIO

struct MiniView: View {
    let t: Int
    var body: some View {
        VStack {
            Text("Row \(t)")
        }
    }
}

struct ContentView: View {
    private func onAppear(){
        socket.connect()
    }
    
    private func onDisappear(){
        socket.disconnect()
    }
    
    var body: some View {
        /*VStack {
            TabView {
                MessengerView()
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chats")
                }
                Text("Settings Screen")
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                }
                Text("Feed Screen")
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Settings")
                }
            }
        }
        .padding()
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)*/
//        MessengerView().onAppear(perform: onAppear)
        SignInView()
//        SignUpView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
