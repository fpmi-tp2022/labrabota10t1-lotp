//
//  CheckBoxButton.swift
//  Hotel
//
//  Created by Вероника on 6/3/22.
//  Copyright © 2022 Вероника. All rights reserved.
//
// MARK: Description
// Данный класс реализует кнопку с выбором

import UIKit

class CheckBoxButton: UIButton {

    var select: Bool = false
    
    override func draw(_ rect: CGRect) {
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
        self.setBackgroundImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
    }
        
    @objc func onPress() {
        select = !select
        if (select) {
            self.setBackgroundImage(UIImage(named: "check"), for: UIControl.State.normal)
        } else {
            self.setBackgroundImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        }
    }

    func isCheck() -> Bool {
        return select
    }
}

