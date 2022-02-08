//
//  ChatInfoView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 23.01.2022.
//

import SwiftUI

struct ChatInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var query: String = ""
    @State var EditingName: Bool = false
    @State var NewName: String = ""
    
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
    }
    
    func TextOnTap() {
        print("Text tapped")
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
        VStack {
            ChatPicture(chat: chat, frameRadius: 150)
                .padding()
            Text(chat.name)
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
                ForEach(getSortedFilteredUsers()) { user in
                    UserRow(user: user, selected: false)
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle("", displayMode: .inline)
        .background(LinearGradient(gradient: Gradient(colors: [.white, .cyan.opacity(0.3)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        .onAppear(perform: onAppear)
        
    }
}

struct ChatInfoView_Previews: PreviewProvider {
    var User1 = User(id: 1, name: "Anton", surname: "Antonov", school_id: 0, class_id: 4, email: "", phone: "", avatar: "")
    static var previews: some View {
        ChatInfoView(chat: Chat(id: 2, name: "Test Chat", creator: 2, picture_url: "", deleted: false, hasLastMsg: true, last_msg_text: "Aboba", last_msg_user: 1, last_msg_time: Date.now, last_msg_username: "", last_msg_userpic: "", admins: [], left: false), users: [])
    }
}
