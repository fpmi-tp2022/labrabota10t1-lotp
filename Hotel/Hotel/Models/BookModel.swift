//
//  BookModel.swift
//  Hotel
//
//  Created by Вероника on 6/5/22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class BookModel {
    
    static func createTicketObject(cityFrom: String, cityTo: String, email: String, name: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
               
        let newObject = NSEntityDescription.insertNewObject(forEntityName: "Tickets", into: managedObjectContext) as NSManagedObject
                 
        newObject.setValue(cityFrom, forKey: "cityFrom")
        newObject.setValue(cityTo, forKey: "cityTo")
        newObject.setValue(name, forKey: "name")
        newObject.setValue(email, forKey: "email")
               
        do {
            try managedObjectContext.save()
        }
            catch let error as NSError {
            print("Data saving error: \(error)")
        }
    }
    
    static func createHotelObject(price: String, address: String, name: String, email: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
          let newObject = NSEntityDescription.insertNewObject(forEntityName: "BookHotels", into: managedObjectContext) as NSManagedObject
          
          newObject.setValue(price, forKey: "price")
          newObject.setValue(address, forKey: "address")
          newObject.setValue(name, forKey: "name")
          newObject.setValue(email, forKey: "email")
        
        do {
            try managedObjectContext.save()
        }
        catch let error as NSError {
            print("Data saving error: \(error)")
        }
      }

    static func getHotelsByEmail(email: String) -> [NSManagedObject] {
        var hotelsAll = [NSManagedObject]()
        var hotels = [NSManagedObject]()
        
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let managedObjectContext = appDelegate.persistentContainer.viewContext
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookHotels")
          do {
              hotelsAll = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for hotel in hotelsAll {
                if (hotel.value(forKey: "email") as! String == email) {
                    hotels.append(hotel)
                }
            }
          }
          catch let error as NSError {
              print("Data loading error: \(error)")
              
          }
          
          return hotels
      }
    
    static func getTicketsByEmail(email: String) -> [NSManagedObject] {
        var ticketsAll = [NSManagedObject]()
        var tickets = [NSManagedObject]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tickets")
        do {
            ticketsAll = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for ticket in ticketsAll {
                if (ticket.value(forKey: "email") as! String == email) {
                    tickets.append(ticket)
                }
            }
        }
        catch let error as NSError {
            print("Data loading error: \(error)")
              
        }
          
        return tickets
    }
}
