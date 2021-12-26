//
//  DateDescriptor.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 26.12.2021.
//

import Foundation

extension String {
    
    func FormatToChatRow() -> String? {
        // TODO: create this function
        return self
    }
    
    func split_by_space() -> [String] {
        return self.components(separatedBy: " ")
    }
    
    func space_deleter() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
}
