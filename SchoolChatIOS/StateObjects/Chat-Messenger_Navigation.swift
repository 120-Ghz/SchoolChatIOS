//
//  Chat-Messenger_Navigation.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 17.12.2021.
//

import Foundation

class NavigationBeetweenChats: ObservableObject {
    @Published var toggler: Bool = false
    @Published var Allower: Bool = true
}

class AuthObj: ObservableObject {
    @Published var Auth: Bool = false
}
