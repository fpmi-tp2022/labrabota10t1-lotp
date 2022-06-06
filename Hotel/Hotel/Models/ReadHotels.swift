//
//  ReadHotels.swift
//  Hotel
//
//  Created by Вероника on 6/2/22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import Foundation

class ReadHotels {
    static func getPlist() -> [[String: String]]? {
        if let path = Bundle.main.path(forResource: "HotelsList", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path) {
            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [[String: String]]
        }
        return nil
    }
}
