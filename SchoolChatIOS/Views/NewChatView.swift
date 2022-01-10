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
    
    func OkButton() {
        SocketIOManager().createChat(creator_id: USER?.id ?? 0, name: chatName)
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
    
    var body: some View {
        TextField("Name", text: $chatName, onEditingChanged: {_ in}, onCommit: OkButton)
        bottomButtons()
    }
}

struct NewChatView_Previews: PreviewProvider {
    static var previews: some View {
        NewChatView()
    }
}
