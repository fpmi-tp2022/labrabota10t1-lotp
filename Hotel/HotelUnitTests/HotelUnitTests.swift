//
//  HotelUnitTests.swift
//  HotelUnitTests
//
//  Created by Nikita on 15/6/22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import XCTest
@testable import Hotel

class HotelUnitTests: XCTestCase {
    
  
    
    func testDataAmount() throws {
        
        let hotels_amount = ReadHotels.getPlist()?.count
        let routes_amount = RoutesModel.getRoutes().count
        
        XCTAssertTrue(hotels_amount != 0, "No hotels added")
        XCTAssertTrue(routes_amount != 0, "No routes added")
    }
    
    func testSignLocalization() throws {
        let locale = NSLocale.preferredLanguages.first!
     
        if locale.hasPrefix("en")
        {
            XCTAssertEqual("Vilnius", NSLocalizedString("Vilnius", comment: ""))
            XCTAssertEqual("Minsk", NSLocalizedString("Minsk", comment: ""))
            XCTAssertEqual("Sign Out", NSLocalizedString("Sign Out", comment: ""))
            XCTAssertEqual("Yes", NSLocalizedString("Yes", comment: ""))
            XCTAssertEqual("Book", NSLocalizedString("Book", comment: ""))
            XCTAssertEqual("No", NSLocalizedString("No", comment: ""))
            XCTAssertEqual("Hello", NSLocalizedString("Hello", comment: ""))
        }
        else if locale.hasPrefix("ru")
        {
            XCTAssertEqual("Вильнюс", NSLocalizedString("Vilnius", comment: ""))
            XCTAssertEqual("Минск", NSLocalizedString("Minsk", comment: ""))
            XCTAssertEqual("Выход", NSLocalizedString("Sign Out", comment: ""))
            XCTAssertEqual("Да", NSLocalizedString("Yes", comment: ""))
            XCTAssertEqual("Забронировать", NSLocalizedString("Book", comment: ""))
            XCTAssertEqual("Нет", NSLocalizedString("No", comment: ""))
            XCTAssertEqual("Здравствуйте", NSLocalizedString("Hello", comment: ""))
        }
        else
        {
            XCTAssertEqual("Vilna", NSLocalizedString("Vilnius", comment: ""))
            XCTAssertEqual("Minsk", NSLocalizedString("Minsk", comment: ""))
            XCTAssertEqual("Desconectar", NSLocalizedString("Sign Out", comment: ""))
            XCTAssertEqual("Sí", NSLocalizedString("Yes", comment: ""))
            XCTAssertEqual("Libro", NSLocalizedString("Book", comment: ""))
            XCTAssertEqual("No", NSLocalizedString("No", comment: ""))
            XCTAssertEqual("Hola", NSLocalizedString("Hello", comment: ""))
            
        }

    }
    
}

