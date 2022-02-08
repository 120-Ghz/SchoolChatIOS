//
//  MessengerView.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.12.2021.
//

import SwiftUI

struct MessengerView: View {
    
    @StateObject private var model = MessengerViewModel()
    @StateObject private var updater = NavigationBeetweenChats()
    
    @State var AddChatsShow = false
    @State private var ConfirmDelete = false
    @State private var ConfirmLeave = false
    @State private var query = ""
    
    private func onAppear(){
        model.create()
    }
    
    private func onCommit() {
        model.FillChats()
    }
    
    private func onChange(state: Bool) {
        model.FillChats()
        model.AllowUpdate = true
        updater.Allower = true
    }
    
    private func BlockUpdates(state: Bool) {
        if updater.Allower {return}
        model.AllowUpdate = false
    }
    
    private var PlusButton: some View {
        NavigationLink(destination: NewChatView(back: updater)) {
            Image(systemName: "plus")
        }
    }
    
    private func Row(chat: Chat) -> some View {
        return ZStack {
            
            ChatRow(chat: chat)
            
            NavigationLink(destination: {
                ChatView(back: updater, chat: chat)
            }) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 0)
            .opacity(0)
        }
    }
    
    private func LeaveChat(chat: Chat) {
        print("leave")
    }
    
    private func DeleteChat(chat: Chat) {
        print("delete")
    }
    
    var body: some View {
        VStack {
            NavigationView {
                    List {
                        ForEach(model.getSortedFilteredChats(query: query)) { chat in
                            Row(chat: chat)
                                .listRowBackground(Color.clear)
                                .swipeActions(edge: .trailing) {
                                    
                                    if (chat.creator == USER!.id) {
                                        Button(action: {
                                            ConfirmDelete = true
                                        }) {
                                            VStack {
                                                Image(systemName: "trash")
                                                Text("Delete")
                                            }
                                        }.tint(.red)
                                    }
                                    
                                    Button(action: {
                                        ConfirmLeave = true
                                    }) {
                                        VStack {
                                            Image(systemName: "")
                                            Text("Leave")
                                        }
                                    }
                                    .tint(.blue)
                                }
                                .confirmationDialog("Are you sure?", isPresented: $ConfirmLeave, titleVisibility: .visible) {
                                    Button("Yes", role: .destructive) {
                                        LeaveChat(chat: chat)
                                    }
                                    Button("Cancel", role: .cancel) {}
                                }
                                .confirmationDialog("Are you sure you want delete \(chat.name)?", isPresented: $ConfirmDelete, titleVisibility: .visible) {
                                    Button("Yes", role: .destructive) {
                                        DeleteChat(chat: chat)
                                    }
                                    Button("Cancel", role: .cancel) {}
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .searchable(text: $query)
                    .navigationBarTitle("Chats", displayMode: .inline)
                    .navigationBarItems(trailing: PlusButton)
                    .background(LinearGradient(gradient: Gradient(colors: [.white, .cyan.opacity(0.3)]), startPoint: .topTrailing, endPoint: .bottomLeading))
            }
            .background(LinearGradient(gradient: Gradient(colors: [.white, .cyan.opacity(0.3)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .onAppear(perform: onAppear)
        .onChange(of: updater.toggler, perform: onChange)
        .onChange(of: updater.Allower, perform: BlockUpdates)
    }
}

struct MessengerView_Previews: PreviewProvider {
    static var previews: some View {
        MessengerView()
    }
}
