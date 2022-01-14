//
//  NewChatView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 31.12.2021.
//

import SwiftUI

final class NewChatViewModel: ObservableObject {
    
    @State var UsersInSchool: [User] = []
    
    let manager = SocketIOManager()
    
    func create() {
        manager.react_users(completionHandler: getSchoolUsers)
    }
    
    func requestSchoolUsers(school_id: Int64) {
        manager.get_users_from_school_id(school_id: school_id)
    }
    
    func getSchoolUsers(incoming: Any) {
        print(incoming)
    }
    
    func createChat(creator_id: Int64, name: String) {
        manager.createChat(creator_id: creator_id, name: name)
    }
    
}

struct NewChatView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var chatName: String = ""
    
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
            }) {
                Text("Готово")
            }
                .padding()
                .disabled(chatName.isEmpty)
            Spacer()
        }
    }
    
    func UsersBox() -> some View{
        return VStack {
            Spacer()
        }
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
//            Spacer()
            UsersBox()
            bottomButtons()
        }
        .padding()
    }
}

struct NewChatView_Previews: PreviewProvider {
    static var previews: some View {
        NewChatView()
    }
}
