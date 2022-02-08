//
//  Date.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 29.12.2021.
//

import Foundation

extension Date {
    func DayFromNumber(num: Int) -> String {
        switch (num) {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "Day"
        }
    }
    
    func MonthFromNumber(num: Int) -> String {
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
        switch(num) {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sep"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return ""
        }
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
                + "\(MonthFromNumber(num: calendar.component(.month, from: self)))"
        }
        
        if (calendar.component(.year, from: self) == calendar.component(.year, from: Date.now)) {
            return "\(MonthNameFromNumber(num: Int(calendar.component(.month, from: self))))"
        }
        
        return "\(MonthFromNumber(num: Int(calendar.component(.month, from: self)))) "
                + "\(calendar.component(.year, from: self))"
    }
}
