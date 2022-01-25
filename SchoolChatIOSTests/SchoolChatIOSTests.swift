//
//  SchoolChatIOSTests.swift
//  SchoolChatIOSTests
//
//  Created by Константин Леонов on 07.12.2021.
//

import XCTest
@testable import SchoolChatIOS

class SchoolChatIOSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDayFromNumber() throws {
//        var components = DateComponents()
//        components.year = 2022
//        components.month = 1
//        components.day = 24
//        let calendar = Calendar(identifier: .gregorian)
//        let date = calendar.date(from: components)
        XCTAssertEqual(Date().DayFromNumber(num: 3), "Tue")
    }
    
    func testMonthFromNumber1DigitInput() throws {
        XCTAssertEqual(Date().MonthFromNumber(num: 4), "04")
    }
    
    func testMonthFromNumber2DigitInput() throws {
        XCTAssertEqual(Date().MonthFromNumber(num: 12), "12")
    }
    
    func testTimeFormat1DigitInputs() throws {
        XCTAssertEqual(Date().TimeFormat(hour: 1, minutes: 6), "01:06")
    }
    
    func testTimeFormat2DigitInputs() throws {
        XCTAssertEqual(Date().TimeFormat(hour: 11, minutes: 46), "11:46")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
