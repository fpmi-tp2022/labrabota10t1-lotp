//
//  HotelUITests.swift
//  HotelUITests
//
//  Created by Paul  on 15.06.22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import XCTest

class HotelUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testSignRegisterSwitch() throws {
        let surname = app.staticTexts["Surname"]
        let name = app.staticTexts["Name"]
        let email = app.staticTexts["Email"]
        let sign = app.segmentedControls.buttons["Sign In"]
        sign.tap()
        XCTAssertFalse(surname.exists)
        XCTAssertFalse(name.exists)
        let register = app.segmentedControls.buttons["Sign Up"]
        register.tap()
        XCTAssertTrue(surname.exists)
        XCTAssertTrue(name.exists)
        sign.tap()
        XCTAssertFalse(surname.exists)
        XCTAssertFalse(name.exists)
    }
}
