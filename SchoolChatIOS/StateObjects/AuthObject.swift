//
//  AuthObject.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 07.02.2022.
//

import Foundation

class AuthObj: ObservableObject {
    @Published var Auth: Bool = false
    @Published var NoUser: Bool = false
    @Published var WrongPassword: Bool = false
}
