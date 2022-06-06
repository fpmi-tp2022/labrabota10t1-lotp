//
//  ProfileViewController.swift
//  Hotel
//
//  Created by Вероника on 6/5/22.
//  Copyright © 2022 Вероника. All rights reserved.
//

// MARK: Description
// Личная информация пользователя о его бронях

import UIKit

class ProfileViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tabBar: TabBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var helloLabel: UILabel!
    
    var hotels = BookModel.getHotelsByEmail(email: UserSettings.userModel.email)
    var tickets = BookModel.getTicketsByEmail(email: UserSettings.userModel.email)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.delegate = self
        helloLabel.text = "\(NSLocalizedString("Hello", comment: "")), \(UserSettings.userModel.username)!"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 75.0
       }
       
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    { return 1 }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (segmentedControl.selectedSegmentIndex == 0) {
            return hotels.count
        }
        else {
            return tickets.count
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! BookHotelsTableViewCell
       
        if (segmentedControl.selectedSegmentIndex == 0) {
            let hotel = Array(hotels)[indexPath.row]
           
            cell.hotelNameLabel.text = NSLocalizedString(hotel.value(forKey: "name") as! String, comment: "")
            cell.addressLabel.text = NSLocalizedString(hotel.value(forKey: "address") as! String, comment: "")
        } else {
            let ticket = Array(tickets)[indexPath.row]
            
            cell.hotelNameLabel.text = NSLocalizedString(ticket.value(forKey: "name") as! String, comment: "")
            cell.addressLabel.text = "\(NSLocalizedString(ticket.value(forKey: "cityFrom") as? String ?? "", comment: "")) - \(NSLocalizedString(ticket.value(forKey: "cityTo") as? String ?? "", comment: ""))"
        }
        return cell
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        tableView.reloadData()
    }
}
