//
//  SignInViewController.swift
//  Hotel
//
//  Created by Вероника on 6/2/22.
//  Copyright © 2022 Вероника. All rights reserved.
//

//MARK: Description
//Позволяет зарегистрировать или войти пользователю

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signSegmentControl: UISegmentedControl!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: Actions
    @IBAction func signInTapped(_ sender: Any) {
        if (settupSign() == true) {
            performSegue(withIdentifier: "showhotels", sender: self)
        }
    }
    
    @IBAction func segmentTapped(_ sender: Any) {
        
        if (signSegmentControl.selectedSegmentIndex == 0) {
            surnameLabel.isHidden = true
            surnameTextField.isHidden = true
            nameLabel.isHidden = true
            nameTextField.isHidden = true
            telephoneTextField.isHidden = true
            telephoneLabel.isHidden = true
        } else {
            surnameLabel.isHidden = false
            surnameTextField.isHidden = false
            nameLabel.isHidden = false
            nameTextField.isHidden = false
            telephoneTextField.isHidden = false
            telephoneLabel.isHidden = false
        }
    }
    
    // MARK: Регистрация, Проверка данных
    func settupSign() -> Bool {
        let username = nameTextField.text!
        let password = passwordTextField.text!
        let email = emailTextField.text!
        let surname = surnameTextField.text!
        let telephone = telephoneTextField.text!
        
        if (signSegmentControl.selectedSegmentIndex == 1) {
            if (username != "" && password != "" && email != "" && surname != "" && telephone != "") {
            
                let userObject = UserModel(username: username, email: email, password: password, userSurname: surname, telephone: telephone)
                UserSettings.userModel = userObject
                return true
            }
            return false
        }
        else {
            if (email != "" && telephone != "") {
                let userGet = UserSettings.userModel
                if (userGet == nil || userGet?.email != email || userGet?.password != password) {
                    
                    return false
                }
                
                return true
            } else {
                return false
            }
        }
    
    }
}
