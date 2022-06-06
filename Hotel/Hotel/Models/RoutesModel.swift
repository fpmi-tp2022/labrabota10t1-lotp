//
//  RoutesModel.swift
//  Hotel
//
//  Created by Вероника on 6/5/22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RoutesModel {
    static func setupDataBase() {
        deleteAll()
        UserDefaults.standard.set(false, forKey: "HasLaunchedOnce")
        if (!UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            
            createRouteObject(appDelegate: appDelegate, managedObjectContext: managedObjectContext, cityFrom: "Minsk", cityTo: "Vilnius", name: "High-Speed", price: "40$", transport: "train")
            
            createRouteObject(appDelegate: appDelegate, managedObjectContext: managedObjectContext, cityFrom: "Vilnius", cityTo: "Minsk", name: "Air Comfort", price: "55$", transport: "plain")
            
            createRouteObject(appDelegate: appDelegate, managedObjectContext: managedObjectContext, cityFrom: "Barcelona", cityTo: "Minsk", name: "Air Flights", price: "105$", transport: "plain")
            
             createRouteObject(appDelegate: appDelegate, managedObjectContext: managedObjectContext, cityFrom: "Barcelona", cityTo: "Paris", name: "Auto First", price: "40$", transport: "bus")
            
            createRouteObject(appDelegate: appDelegate, managedObjectContext: managedObjectContext, cityFrom: "Minsk", cityTo: "Paris", name: "High-Speed", price: "190 Br", transport: "train")
            
            createRouteObject(appDelegate: appDelegate, managedObjectContext: managedObjectContext, cityFrom: "Minsk", cityTo: "Barcelona", name: "White Auto", price: "200 Br", transport: "bus")
            
             createRouteObject(appDelegate: appDelegate, managedObjectContext: managedObjectContext, cityFrom: "Minsk", cityTo: "Rome", name: "Air Miss", price: "230 Br", transport: "plain")
            do {
               try managedObjectContext.save()
           }
           catch let error as NSError {
               print("Data saving error: \(error)")
           }
        }
    }
    
    static func createRouteObject(appDelegate: AppDelegate, managedObjectContext: NSManagedObjectContext, cityFrom: String, cityTo: String, name: String, price: String, transport: String) {
        let newObject = NSEntityDescription.insertNewObject(forEntityName: "Routes", into: managedObjectContext) as NSManagedObject
        
        newObject.setValue(cityFrom, forKey: "cityFrom")
        newObject.setValue(cityTo, forKey: "cityTo")
        newObject.setValue(name, forKey: "name")
        newObject.setValue(price, forKey: "price")
        newObject.setValue(transport, forKey: "transport")
    }

    static func getRoutes() -> [NSManagedObject] {
        var routes = [NSManagedObject]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Routes")
        do {
            routes = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Data loading error: \(error)")
            
        }
        
        return routes
    }
    
    static func getRoutesByCitiesAndCategories(routes: [NSManagedObject], cityTo: String, cityFrom: String, plain: Bool, train: Bool, bus: Bool) -> Set<NSManagedObject>{
        
        print("1 \(cityTo)")
        print("2 \(cityFrom)")
        var choose = Set<NSManagedObject>()
        
        if((!plain && !train && !bus) || (plain && train && bus)) {
            for route in routes {
                print(NSLocalizedString(route.value(forKey: "cityTo") as! String, comment: ""))
                print(NSLocalizedString(route.value(forKey: "cityFrom") as! String, comment: ""))
                if (NSLocalizedString(route.value(forKey: "cityTo") as! String, comment: "") == cityTo && NSLocalizedString(route.value(forKey: "cityFrom") as! String, comment: "") == cityFrom) {
                    choose.insert(route)
                }
            }
        } else {
            if (plain){
                getRoutesByBool(routes: routes, cityTo: cityTo, cityFrom: cityFrom, transport: "plain", set: &choose)
            }
            if (train) {
                getRoutesByBool(routes: routes, cityTo: cityTo, cityFrom: cityFrom, transport: "train", set: &choose)
            }
            if (bus) {
            getRoutesByBool(routes: routes, cityTo: cityTo, cityFrom: cityFrom, transport: "plain", set: &choose)
            }
        }
        
        return choose
    }
    
    static func getRoutesByBool(routes: [NSManagedObject], cityTo: String, cityFrom: String, transport: String, set: inout Set<NSManagedObject>) {
        
        for route in routes {
            if (NSLocalizedString(route.value(forKey: "cityTo") as! String, comment: "") == cityTo && NSLocalizedString(route.value(forKey: "cityFrom") as! String, comment: "") == cityFrom && route.value(forKey: "transport") as! String == transport) {
                set.insert(route)
            }
        }
    }
    
    static func deleteAll() -> Bool {
        let objects = getRoutes()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   
        let managedObjectContext = appDelegate.persistentContainer.viewContext
       
        for i in objects {
            managedObjectContext.delete(i as NSManagedObject)
            do {
               try managedObjectContext.save() //Пробуем сохранить изменения в базе данных
            }
            catch _ as NSError {
                //print("Data removing error: \(error)") //В случае возникновения ошибки, выводим ее в консоль
                return false
            }
        }
        
        return true
    }
}
