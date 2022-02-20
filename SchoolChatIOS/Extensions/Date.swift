//
//  Date.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 29.12.2021.
//

import Foundation

enum WeekDay: Int {
    case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    static let allValues = [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]
}

enum Months: Int {
    case January = 1, February, March, April, May, June, July, August, September, October, November, December
    static let allValues = [January, February, March, April, May, June, July, August, September, October, November, December]
}

extension Date {
    func DayFromNumber(num: Int) -> String {
        for e in WeekDay.allValues {
            if e.rawValue == num {
                return String("\(e)".prefix(3))
            }
        }
        return "Day"
    }
    
    func MonthFormat(num: Int) -> String {
        switch (num) {
        case 1, 2, 3, 4, 5, 6, 7, 8, 9:
            return "0\(num)"
        case 10, 11, 12:
            return String(num)
        default:
            return ""
        }
    }
    
    func MonthNameFromNumber(num: Int) -> String {
        for e in Months.allValues {
            if e.rawValue == num {
                return String("\(e)".prefix(3))
            }
        }
        return "Err"
    }
    
    func TimeFormat(hour: Int, minutes: Int) -> String {
        var hoursstr = String(hour)
        var minutestr = String(minutes)
        if (hour < 10) {
            hoursstr = "0" + hoursstr
        }
        if (minutes < 10) {
            minutestr = "0" + minutestr
        }
        return hoursstr + ":" + minutestr
    }
    
    func FormatDateToChatRow() -> String {
        
        let calendar = Calendar.current
        
        let todaystart = calendar.startOfDay(for: Date.now)
        let timedelta_since_today = abs(Int(self.timeIntervalSince1970
                                            - todaystart.timeIntervalSince1970))
        
        if (self.timeIntervalSince1970 >= todaystart.timeIntervalSince1970) {
            return TimeFormat(hour: calendar.component(.hour, from: self),
                              minutes: calendar.component(.minute, from: self))
        }
        
        if (timedelta_since_today < 24*7*3600) {
            return DayFromNumber(num: Int(calendar.component(.weekday, from: self)))
        }
        
        if (calendar.component(.month, from: self) == calendar.component(.month, from: Date.now)) {
            return "\(calendar.component(.day, from: self))."
                + "\(MonthFormat(num: calendar.component(.month, from: self)))"
        }
        
        if (calendar.component(.year, from: self) == calendar.component(.year, from: Date.now)) {
            return "\(MonthNameFromNumber(num: Int(calendar.component(.month, from: self))))"
        }
        
        return "\(MonthFormat(num: Int(calendar.component(.month, from: self)))) "
                + "\(calendar.component(.year, from: self))"
    }
}
