//
//  TabBarView.swift
//  Hotel
//
//  Created by Вероника on 6/5/22.
//  Copyright © 2022 Вероника. All rights reserved.
//
import Foundation
import UIKit

protocol ViewOutputDelegate {
    func nextScene(name: String)
    func prepareAlert(alert: UIAlertController)
}
//@IBDesignable
final class TabBarView: UIView {

    @IBOutlet weak var hotelsButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    var delegate : ViewOutputDelegate?
    
    @IBAction func hotelTapped(_ sender: Any) {
        delegate?.nextScene(name: "hotelNVC")
    }
    
    @IBAction func profileTapped(_ sender: Any) {
            delegate?.nextScene(name: "profileNVC")
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    private func configureView() {
        guard let view = self.loadFromNib(nibName: "TabBarView") else {return}
        view.frame = self.bounds
        self.addSubview(view)
        hotelsButton.setTitle(NSLocalizedString("Hotels", comment: ""), for: .normal)
        profileButton.setTitle(NSLocalizedString("Profile", comment: ""), for: .normal)
    }
}
