//
//  ChooseTransportViewController.swift
//  Hotel
//
//  Created by Вероника on 6/3/22.
//  Copyright © 2022 Вероника. All rights reserved.
//
// MARK: Description
// Позволяет выбрать транспорт для фильтрации билетов

import UIKit

class ChooseTransportViewController: BaseViewController {

    @IBOutlet weak var tabBar: TabBarView!
    @IBOutlet weak var bus: CheckBoxButton!
    @IBOutlet weak var train: CheckBoxButton!
    @IBOutlet weak var plain: CheckBoxButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MapViewController
        vc.plain = plain.isCheck()
        vc.bus = bus.isCheck()
        vc.train = train.isCheck()
    }
}
