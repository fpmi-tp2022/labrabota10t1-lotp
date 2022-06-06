//
//  HotelCollectionViewCell.swift
//  Hotel
//
//  Created by Вероника on 6/2/22.
//  Copyright © 2022 Вероника. All rights reserved.
//
// MARK: Description
// Представление ячейки коллекции отелей

import UIKit

class HotelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    
    func setup(with hotel: [String: String]) {
        hotelNameLabel.text = NSLocalizedString(hotel["name"]!, comment: "")
        hotelImageView.image = UIImage(named: hotel["image"] ?? "0")
    }
}
