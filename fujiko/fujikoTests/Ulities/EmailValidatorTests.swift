//
//  EmailValidatorTests.swift
//  fujikoTests
//
//  Created by Charlie Cai on 22/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import XCTest
@testable import fujiko

class EmailValidatorTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {

    }
    
    func testEmailIsValidWhenEmailMeets() {
        XCTAssert("cai.charlie@hotmail.com".isValidEmail(), "email is not valid")
        XCTAssert("cai@hotmail.com".isValidEmail(), "email is not valid")
        XCTAssert("charlie@hotmail.com".isValidEmail(), "email is not valid")
        XCTAssert("cai.charlie@baidu.com".isValidEmail(), "email is not valid")
        XCTAssert("cai.charlie@google.com".isValidEmail(), "email is not valid")
        XCTAssert("cai.charlie@facebook.com".isValidEmail(), "email is not valid")
    }

    func testEmailIsInvalidWhenEmailIsEmpty() {
        XCTAssert(!"".isValidEmail(), "empty email is not valid")
    }
    
    func testEmailIsInvalidWhenEmailWithoutAtSign() {
        XCTAssert(!"cai.charliehotmail.com".isValidEmail(), "email without @ is not valid")
    }
    
    func testEmailIsInvalidWhenEmailWithoutRightDomain() {
        XCTAssert(!"cai.charlie@hotmail".isValidEmail(), "email without Right Domain is not valid")
        XCTAssert(!"cai.charlie@JOJO".isValidEmail(), "email without Right Domain is not valid")
    }

}
