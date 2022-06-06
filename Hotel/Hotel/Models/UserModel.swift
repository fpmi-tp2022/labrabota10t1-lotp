//
//  UserModel.swift
//  Hotel
//
//  Created by Вероника on 6/2/22.
//  Copyright © 2022 Вероника. All rights reserved.
//

import Foundation

final class UserSettings {
    private enum SettingsKey: String {
        case userName
        case userModel
    }
    
    static var userModel: UserModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKey.userModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? UserModel else {return nil}
            return decodedModel
            
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKey.userModel.rawValue
            
            if let userModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
}


class UserModel: NSObject, NSCoding {
    let email: String
    let username: String
    let password: String
    let userSurname: String
    let telephone: String
    
    init(username: String, email: String, password: String, userSurname: String, telephone: String) {
        self.email = email
        self.username = username
        self.password = password
        self.userSurname = userSurname
        self.telephone = telephone
    }

    func encode(with coder: NSCoder) {
        coder.encode(email, forKey: "email")
        coder.encode(username, forKey: "username")
        coder.encode(password, forKey: "password")
        coder.encode(telephone, forKey: "telephone")
        coder.encode(userSurname, forKey: "userSurname")
    }
    
    required init?(coder: NSCoder) {
        email = coder.decodeObject(forKey: "email") as? String ?? ""
        username = coder.decodeObject(forKey: "username") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
        telephone = coder.decodeObject(forKey: "telephone") as? String ?? ""
        userSurname = coder.decodeObject(forKey: "userSurname") as? String ?? ""
    }
}
