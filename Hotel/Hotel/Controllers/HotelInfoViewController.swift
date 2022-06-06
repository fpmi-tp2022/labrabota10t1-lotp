//
//  HotelInfoViewController.swift
//  Hotel
//
//  Created by Вероника on 6/2/22.
//  Copyright © 2022 Вероника. All rights reserved.
//
// MARK: Description
// Предоставляет информацию о выбранном отеле
// а также забронировать отель
// при бронировании высветиться подтверждение

import UIKit

class HotelInfoViewController: BaseViewController {

    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var hotelNameLabel: UILabel!
    
    @IBOutlet weak var tabBar: TabBarView!
    var hotel: [String: String]? = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (hotel != nil) {
            hotelNameLabel.text = hotel?["name"]
            hotelImageView.image = UIImage(named: (hotel?["image"])!)
            priceLabel.text = NSLocalizedString((hotel?["price"])!, comment: "")
            addressLabel.text = NSLocalizedString((hotel?["address"])!, comment: "")
            descriptionLabel.text = NSLocalizedString((hotel?["description"])!, comment: "")
            telephoneLabel.text = hotel?["telephone"]
        }
        tabBar.delegate = self
    }

    // MARK: Book
    @IBAction func bookTapped(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("Book", comment: ""), message: NSLocalizedString("Are you sure ou want to book a hotel?", comment: ""), preferredStyle: .alert)
          
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: bookAlertYes))
          
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    func bookAlertYes(alert: UIAlertAction!) {
        BookModel.createHotelObject(price: (hotel?["price"])!, address: (hotel?["address"])!, name: (hotel?["name"])!, email: UserSettings.userModel.email)
        performSegue(withIdentifier: "choose", sender: self)
    }
}
