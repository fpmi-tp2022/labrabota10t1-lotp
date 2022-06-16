//
//  SignOutUITest.swift
//  HotelUITests
//
//  Created by Paul  on 15.06.22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import XCTest

class SignOutUITest: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    
    func testSignRegisterSwitch() throws {
        app.segmentedControls.buttons["Sign In"].tap()
        app.buttons.containing(.staticText, identifier:"Sign").element.tap()
        app.navigationBars["Hotels"].buttons["Sign Out"].tap()
    }
}
