//
//  NewChatView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 31.12.2021.
//

import SwiftUI

struct NewChatView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State var chatName: String = ""
    @ObservedObject var back: NavigationBeetweenChats
    @StateObject var model = NewChatViewModel()
    
    func OkButton() {
        model.createChat(creator_id: USER?.id ?? 0, name: chatName)
        chatName = ""
    }
    
    func bottomButtons() -> some View {
        return HStack {
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back")
            }
            .padding()
            Spacer()
            Spacer()
            Button(action: {
                OkButton()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Готово")
            }
            .padding()
            .disabled(chatName.isEmpty)
            Spacer()
        }
    }
    
    func PressedUser(user: User) {
        if !CheckUserSelect(user: user) {
            model.UsersToSend.append(user)
        } else {
            if let index = model.UsersToSend.firstIndex(of: user) {
                model.UsersToSend.remove(at: index)
            }
        }
    }
    
    func CheckUserSelect(user: User) -> Bool {
        return model.UsersToSend.contains(user)
    }
    
    func UsersBox() -> some View {
        return VStack {
            List {
                ForEach(model.FilteredUsers) { user in
                    Button(action: {PressedUser(user: user)}) {
                        UserRow(user: user, selected: CheckUserSelect(user: user), creator: false, admin: false)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    
    func OnAppear() {
        print("OnAppear")
        model.create()
        model.requestSchoolUsers(school_id: 4)
    }
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Name", text: $chatName, onEditingChanged: {_ in}, onCommit: OkButton)
                .padding(.vertical, 2)
                .padding(.horizontal, 7)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.blue, lineWidth: 2)
                )
            UsersBox()
            bottomButtons()
        }
        .padding()
        .onAppear(perform: OnAppear)
        .onDisappear(perform: {
            back.toggler.toggle()
        })
    }
}

struct NewChatView_Previews: PreviewProvider {
    static var previews: some View {
        NewChatView(back: NavigationBeetweenChats())
    }
}
