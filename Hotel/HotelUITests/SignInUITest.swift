//
//  SignInUITest.swift
//  HotelUITests
//
//  Created by Paul  on 15.06.22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import XCTest

class SignInUITest: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }


  func testSignIn() throws {
        let button = app.segmentedControls.buttons["Sign In"]
        button.tap()
        
        let email = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0)
        email.tap()
        email.typeText("testemail@gmail.com")
        
        let e = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        e.tap()
        
        let element = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        element.tap()
        element.typeText("testpassword")
        e.tap()
        app.staticTexts["Sign"].tap()
        
    }
}
