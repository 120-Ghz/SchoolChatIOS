//
//  Date.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 29.12.2021.
//

import Foundation

extension Date {
    func FormatDateToChatRow() -> String {
        
        func DayFromNumber(num: Int) -> String {
            switch (num) {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                return ""
            }
        }
        
        func MonthFromNumber(num: Int) -> String {
            switch (num) {
            case 1:
                return "January"
            case 2:
                return "February"
            case 3:
                return "March"
            case 4:
                return "April"
            case 5:
                return "May"
            case 6:
                return "June"
            case 7:
                return "July"
            case 8:
                return "August"
            case 9:
                return "September"
            case 10:
                return "October"
            case 11:
                return "November"
            case 12:
                return "December"
            default:
                return ""
            }
        }
        
        let calendar = Calendar.current
        let diff = abs(Int(self.timeIntervalSince1970 - Date.now.timeIntervalSince1970))
        let hour_diff = diff/3600
        
        if (hour_diff < 24) {
            return "\(calendar.component(.hour, from: self)):\(calendar.component(.minute, from: self))"
        }
        
        if (hour_diff < 48) {
            return "Yesterday"
        }
        
        if (hour_diff < 24*7) {
            return DayFromNumber(num: Int(calendar.component(.weekday, from: self)))
        }
        
        if (calendar.component(.year, from: self) == calendar.component(.year, from: Date.now)) {
            return MonthFromNumber(num: Int(calendar.component(.month, from: self)))
        }
        
        return "\(MonthFromNumber(num: Int(calendar.component(.month, from: self)))) \(calendar.component(.year, from: self))"
    }
}
