//
//  ChatInfoView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 23.01.2022.
//

import SwiftUI
import ExytePopupView

struct ChatInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var query: String = ""
    @State var EditingName: Bool = false
    @State var NewName: String = ""
    @State var DisplayingName: String = ""
    
    var chat: Chat
    var users: [User]
    
    func getSortedFilteredUsers() -> [User] {
        if query == "" {
            return users
        }
        return users.filter {$0.name.lowercased().contains(query.lowercased()) || $0.surname.lowercased().contains(query.lowercased())}
    }
    
    func onAppear() {
        NewName = chat.name
        DisplayingName = chat.name
    }
    
    func EditedName() {
        withAnimation{
            EditingName = false
        }
        DisplayingName = NewName
        print("Edited Name")
    }
    
    func TextOnTap() {
        withAnimation {
            EditingName.toggle()
        }
    }
    
    func AddUser() {
        print("Aboba adding user")
    }
    
    func membersWord(number: Int) -> String {
        if number%10 == 1 {
            return "участник"
        }
        if number%10 < 5 && number%10 != 0 {
            return "участника"
        }
        return "участников"
    }
    
    var body: some View {
        ZStack {
            VStack {
                ChatPicture(chat: chat, frameRadius: 150)
                    .padding()
                Text(DisplayingName)
                    .font(.title)
                    .onTapGesture { TextOnTap() }
                Text("\(users.count) \(membersWord(number: users.count))")
                    .font(.body)
                    .foregroundColor(.gray)
                // TODO: Chat members count
                Divider()
                
                TextField("Найти пользователей", text: $query)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                    .background(Capsule().fill(Color.gray.opacity(0.2)))
                    .padding(.horizontal)
                List {
                    
                    HStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .frame(width: 35, height: 35)
                        Text("Add User")
                            .font(.headline)
                            .fontWeight(.regular)
                    }
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        AddUser()
                    }
                    
                    ForEach(getSortedFilteredUsers()) { user in
                        UserRow(user: user, selected: false, creator: user.id == chat.creator, admin: chat.admins.contains(user.id))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("", displayMode: .inline)
            .background(LinearGradient(gradient: Gradient(colors: [.white, .cyan.opacity(0.3)]), startPoint: .topTrailing, endPoint: .bottomLeading))
            .onAppear(perform: onAppear)
            if (EditingName) {
                Color.black.opacity(0.3).ignoresSafeArea()
                    .onTapGesture {
                        EditedName()
                    }
            }
        }.popup(isPresented: $EditingName,type: .toast, position: .bottom, closeOnTap: false) {
            VStack {
                Text("Название чата")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                
                TextField("New name", text: $NewName, onCommit: EditedName)
                    .padding(10)
                    .foregroundColor(.black)
                    .background(Capsule().fill(.gray.opacity(0.2)))
                    .padding(.horizontal)
                    .padding(.bottom, 40)
            }
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}

struct ChatInfoView_Previews: PreviewProvider {
    var User1 = User(id: 1, name: "Anton", surname: "Antonov", school_id: 0, class_id: 4, email: "", phone: "", avatar: "")
    static var previews: some View {
        ChatInfoView(chat: Chat(id: 2, name: "Test Chat", creator: 2, picture_url: "", deleted: false, hasLastMsg: true, last_msg_text: "Aboba", last_msg_user: 1, last_msg_time: Date.now, last_msg_username: "", last_msg_userpic: "", admins: [], left: false), users: [])
    }
}
