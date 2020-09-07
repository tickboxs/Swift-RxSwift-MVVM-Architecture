//
//  DateConvertorTests.swift
//  fujikoTests
//
//  Created by Charlie Cai on 22/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import XCTest

@testable import fujiko
class DateConvertorTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {

    }
    
    func testDateStringWhenUnixTimestampGiven() {
        
        let testCases = [(1584889774334, "2020-03-22 23:09:34", "2020/03/22/23/09/34"),
                         (1111889771111, "2005-03-27 10:16:11", "2005/03/27/10/16/11"),
                         (1121889771111, "2005-07-21 04:02:51", "2005/07/21/04/02/51"),
                         (0111889771111, "1973-07-19 08:29:31", "1973/07/19/08/29/31"),
                         (1121389771111, "2005-07-15 09:09:31", "2005/07/15/09/09/31")]
        
        for testCase in testCases {
            // Test Without format string
            XCTAssert(Date.timeIntervalChangeToTimeStr(
                timeInterval: TimeInterval(testCase.0),
                dateFormat: nil) == testCase.1)
            
            // Test With format string
            XCTAssert(Date.timeIntervalChangeToTimeStr(
                timeInterval: TimeInterval(testCase.0),
                dateFormat: "yyyy/MM/dd/HH/mm/ss") == testCase.2)
        }
        
    }
    
    func testUnixTimestampWhenTimeStrGiven() {
        
        // For Now Can only get 10 digits timestamp,
        // need to find a way to get 13 digits timestamp in future
        let testCases = [(1584889774000, "2020-03-22 23:09:34", "2020/03/22/23/09/34"),
                         (1111889771000, "2005-03-27 10:16:11", "2005/03/27/10/16/11"),
                         (1121889771000, "2005-07-21 04:02:51", "2005/07/21/04/02/51"),
                         (0111889771000, "1973-07-19 08:29:31", "1973/07/19/08/29/31"),
                         (1121389771000, "2005-07-15 09:09:31", "2005/07/15/09/09/31")]
        
        for testCase in testCases {
            // Test Without format string
            XCTAssert(Date.timeStrChangeTotimeInterval(
                timeStr: testCase.1, dateFormat: nil)
                .expect(message: "Could not convert") == TimeInterval(testCase.0))
            
            // Test With format string
            XCTAssert(Date.timeStrChangeTotimeInterval(
                 timeStr: testCase.2, dateFormat: "yyyy/MM/dd/HH/mm/ss")
                .expect(message: "Could not convert") == TimeInterval(testCase.0))
        }
        
    }

}
