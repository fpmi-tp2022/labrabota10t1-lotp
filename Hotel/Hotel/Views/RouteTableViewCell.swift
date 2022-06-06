//
//  RouteTableViewCell.swift
//  Hotel
//
//  Created by Вероника on 6/5/22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transportLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var delegate: ViewOutputDelegate?
    var cityTo: String = ""
    var cityFrom: String = ""
     
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /*@IBAction func bookTapped(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("Book", comment: ""), message: NSLocalizedString("Are you sure ou want to book a hotel?", comment: ""), preferredStyle: .alert)
          
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: bookAlertYes))
          
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel, handler: nil))
        
        delegate?.prepareAlert(alert: alert)
    }
    
    func bookAlertYes(alert: UIAlertAction!) {
        print(cityFrom)
        print(cityTo)
        
        BookModel.createTicketObject(cityFrom: cityFrom, cityTo: cityTo, email: UserSettings.userModel.email, name: nameLabel.text!)
        
        delegate?.nextScene(name: "hotelNVC")
    }*/
}
