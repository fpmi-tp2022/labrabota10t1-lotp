//
//  UIView+Nib.swift
//  Hotel
//
//  Created by Вероника on 6/5/22.
//  Copyright © 2022 Вероника. All rights reserved.
//
import Foundation
import UIKit

// MARK: Extension UIView
// Позволяет загружать xib файлы
extension UIView {
    func loadFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

// MARK: BaseViewController
// Базовый класс для использования делегатов, управления сценами и
// добавление элементов на панель навигации
class BaseViewController: UIViewController, ViewOutputDelegate {
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Sign Out", comment: ""), style: .done, target: self, action: #selector(signOutTapped))
    }
    
    @objc func signOutTapped() {
        nextScene(name: "sign")
    }
    
    func nextScene(name: String) {
        if (name == "hotels") {
            let vc = storyboard?.instantiateViewController(identifier: name) as! HotelsViewController
            vc.modalPresentationStyle = .fullScreen
                   present(vc, animated: true, completion: nil)
        }
        else if (name == "profile"){
            let vc = storyboard?.instantiateViewController(identifier: name) as! ProfileViewController
            vc.modalPresentationStyle = .fullScreen
                   present(vc, animated: true, completion: nil)
        } else if (name == "sign") {
            let vc = storyboard?.instantiateViewController(identifier: name) as! SignInViewController
            vc.modalPresentationStyle = .fullScreen
                   present(vc, animated: true, completion: nil)
        } else if (name == "hotelNVC"){
            let vc = storyboard?.instantiateViewController(identifier: name) as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
                   present(vc, animated: true, completion: nil)
        } else if (name == "profileNVC") {
            let vc = storyboard?.instantiateViewController(identifier: name) as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
                   present(vc, animated: true, completion: nil)
        }
    }
    
    func prepareAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

}


