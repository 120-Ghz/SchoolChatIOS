//
//  DateDescriptor.swift
//  SchoolChatIOS
//
//  Created by Константин Леонов on 26.12.2021.
//

import Foundation

extension String {
    
    func JSDateToDate() -> Date {
        // 2021-12-28T22:20:50.508Z
        let EndYearIndex = self.index(self.startIndex, offsetBy: 4)
        let Year = String(self[..<EndYearIndex])
        
        let StartMonthIndex = self.index(self.startIndex, offsetBy: 5)
        let EndMonthIndex = self.index(self.startIndex, offsetBy: 7)
        let Month = String(self[StartMonthIndex..<EndMonthIndex])
        
        let StartDayIndex = self.index(self.startIndex, offsetBy: 8)
        let EndDayIndex = self.index(self.startIndex, offsetBy: 10)
        let Day = String(self[StartDayIndex..<EndDayIndex])
        
        let HourStartIndex = self.index(self.startIndex, offsetBy: 11)
        let HourEndIndex = self.index(self.startIndex, offsetBy: 13)
        let Hour = String(self[HourStartIndex..<HourEndIndex])
        
        let MinuteStartIndex = self.index(self.startIndex, offsetBy: 14)
        let MinuteEndIndex = self.index(self.startIndex, offsetBy: 16)
        let Minute = String(self[MinuteStartIndex..<MinuteEndIndex])
        
        let SecondsStartIndex = self.index(self.startIndex, offsetBy: 17)
        let SecondsEndIndex = self.index(self.startIndex, offsetBy: 19)
        let Seconds = String(self[SecondsStartIndex..<SecondsEndIndex])
        
        var datecomp = DateComponents()
        datecomp.year = Int(Year)
        datecomp.month = Int(Month)
        datecomp.day = Int(Day)
        datecomp.hour = Int(Hour)
        datecomp.minute = Int(Minute)
        datecomp.second = Int(Seconds)
//        datecomp.timeZone = TimeZone(abbreviation: "")
        let calendar = Calendar(identifier: .gregorian)
        guard let date = calendar.date(from: datecomp) else { return Date.now }
        
        return date
    }
    
    func split_by_space() -> [String] {
        return self.components(separatedBy: " ")
    }
    
    func space_deleter() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
}
