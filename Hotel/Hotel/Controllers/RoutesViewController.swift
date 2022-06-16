//
//  RoutesViewController.swift
//  Hotel
//
//  Created by Вероника on 6/5/22.
//  Copyright © 2022 Вероника. All rights reserved.
//
// MARK: Description
// Выводит все доступные билеты с учетом фильтрации и выбором городов

import UIKit
import CoreData

class RoutesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tabBar: TabBarView!
    @IBOutlet weak var routesTableView: UITableView!
    
    var routesAll = [NSManagedObject]()
    var routes = Set<NSManagedObject>()
    var routeSelected = NSManagedObject()
    
    var plain: Bool = false
    var train: Bool = false
    var bus: Bool = false
    var cityTo: String = ""
    var cityFrom: String = ""
    var cityToEnglish: String = ""
    var cityFromEnglish: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routesTableView.delegate = self
        tabBar.delegate = self
        nameLabel.text = "\(cityFrom) - \(cityTo)"
    }

    override func viewWillAppear(_ animated: Bool) {
        routesAll = RoutesModel.getRoutes()
        
        routes = RoutesModel.getRoutesByCitiesAndCategories(routes: routesAll, cityTo: cityTo, cityFrom: cityFrom, plain: plain, train: train, bus: bus)
        
        print(routes)
        if (routes.count != 0) {
            cityToEnglish = Array(routes)[0].value(forKey: "cityTo") as! String
            cityFromEnglish = Array(routes)[0].value(forKey: "cityFrom") as! String
        }
        
        routesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 75.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = routesTableView.dequeueReusableCell(withIdentifier: "routeCell")! as! RouteTableViewCell
        
        let route = Array(routes)[indexPath.row]
        
        cell.nameLabel.text = route.value(forKey: "name") as? String ?? ""
        cell.priceLabel.text = route.value(forKey: "price") as? String ?? ""
        cell.transportLabel.text = NSLocalizedString(route.value(forKey: "transport") as? String ?? "", comment: "")
        cell.cityFrom = cityFromEnglish
        cell.cityTo = cityToEnglish
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        routeSelected = Array(routes)[indexPath.row]
    }
    @IBAction func bookTapped(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("Book", comment: ""), message: NSLocalizedString("Are you sure ou want to buy a ticket?", comment: ""), preferredStyle: .alert)
          
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: bookAlertYes))
          
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    func bookAlertYes(alert: UIAlertAction!) {
        print(cityFrom)
        print(cityTo)
        
        BookModel.createTicketObject(cityFrom: cityFromEnglish, cityTo: cityToEnglish, email: UserSettings.userModel.email, name: routeSelected.value(forKey: "name") as! String)
        
        self.nextScene(name: "hotelNVC")
    }
}
