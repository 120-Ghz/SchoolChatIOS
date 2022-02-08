//
//  UserRow.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 20.01.2022.
//

import SwiftUI

struct UserRow: View {
    let user: User
    let radius: CGFloat = 35
    let selected: Bool
    let creator: Bool?
    let admin: Bool?
    
    func PicText() -> String {
        return String(user.name.prefix(1)).uppercased() + String(user.surname.prefix(1)).uppercased()
    }
    
    var Avatar: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: radius, height: radius)
                Text(PicText())
                    .font(.system(size: radius/2))
                    .foregroundColor(Color.white)
            }
        }
    }
    
    func FormattedText() -> String {
        return "\(user.name) \(user.surname)"
    }
    
    var Name: some View {
        Text(FormattedText())
            .font(.headline)
            .fontWeight(.regular)
            .foregroundColor(selected ? Color.blue : Color.black)
            .background(Color.clear)
    }
    
    var body: some View {
        HStack {
            Avatar
            Name
            Spacer()
            if creator! {
                Text("Создатель")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            else if admin! {
                Text("Админ")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: User(id: 1, name: "aboba", surname: "Frolov", school_id: 4, class_id: 1, email: "sd", phone: "88005553535", avatar: ""), selected: false, creator: true, admin: false)
    }
}
