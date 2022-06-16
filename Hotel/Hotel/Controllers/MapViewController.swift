//
//  MapViewController.swift
//  Hotel
//
//  Created by Вероника on 6/5/22.
//  Copyright © 2022 Вероника. All rights reserved.
//
// MARK: Description
// С помощью длинного нажатия позволяет выбрать города
// Или же ввести их

import UIKit
import MapKit
import CoreData

class MapViewController: BaseViewController {

    @IBOutlet weak var cityFromTextField: UITextField!
    @IBOutlet weak var cityToTextField: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var tabBar: TabBarView!
    var isCity: Bool = false
    var annotationFrom: MKPointAnnotation = MKPointAnnotation()
    var annotationTo: MKPointAnnotation = MKPointAnnotation()
    
    var plain: Bool = false
    var train: Bool = false
    var bus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.delegate = self
        let longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(handleLongPressGesture(sender:)))
        
        map.addGestureRecognizer(longPressGesture)
        
        cityToTextField.tag = 2
        cityFromTextField.tag = 1
        cityFromTextField.addTarget(self, action: #selector(didFieldChanged), for: .editingDidBegin)
        cityToTextField.addTarget(self, action: #selector(didFieldChanged), for: .editingDidBegin)
        //cityToTextField.delegate = self
        //cityFromTextField.delegate = self
    }
    
    @objc func didFieldChanged(sender: UITextField) {
        if (sender.tag == 1) {
            isCity = false
        } else if (sender.tag == 2) {
            isCity = true
        }
    }
    
// MARK: Map Functions
    @objc func handleLongPressGesture(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: map)
        let geocoder = CLGeocoder()
        let coord = map.convert(point, toCoordinateFrom: map)
        let location = CLLocation.init(latitude: coord.latitude, longitude: coord.longitude)
       
       
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil) {
                    print("Geocode failure")
                    return
                }
            
                if let pl = placemarks?.first {
                    if pl.locality != nil{
                    self.setAnnotationToMap(type: self.isCity, title: pl.locality!, coordinate: coord)
                    }
                } else {
                    print("Error")
                }
            
            }
        )
    }
    
    func setAnnotationToMap(type: Bool, title: String, coordinate: CLLocationCoordinate2D) {
        if (type == false) {
            map.removeAnnotation(annotationFrom)
            annotationFrom.title = title
            annotationFrom.coordinate = coordinate
            map.addAnnotation(annotationFrom)
            cityFromTextField.text = title
        } else {
            map.removeAnnotation(annotationTo)
            annotationTo.title = title
            annotationTo.coordinate = coordinate
            map.addAnnotation(annotationTo)
            cityToTextField.text = title
        }
    }
    
// MARK: Go to next controller
    @IBAction func findTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RoutesViewController
        vc.plain = plain
        vc.train = train
        vc.bus = bus
        vc.cityTo = cityToTextField.text!
        vc.cityFrom = cityFromTextField.text!
    }
    
}
