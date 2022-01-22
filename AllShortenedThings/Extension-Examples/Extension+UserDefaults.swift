//
//  Extension+UserDefaults.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import Foundation

extension UserDefaults {
    
    struct AnyModel:Codable {
        let name:String?
    }
    
    enum UserDefaultKeys: String , CaseIterable {
        case token
        case anyModel
        case rememberMe
        case sessionId
        case userName
        case password
    }
    
    var rememberMe: Bool {
        get {
            return bool(forKey: UserDefaultKeys.rememberMe.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.rememberMe.rawValue)
            synchronize()
        }
    }
    
    var userName: String {
        get {
            return string(forKey: UserDefaultKeys.userName.rawValue) ?? ""
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.userName.rawValue)
            synchronize()
        }
    }
    
    var password: String {
        get {
            return string(forKey: UserDefaultKeys.password.rawValue) ?? ""
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.password.rawValue)
            synchronize()
        }
    }
    
    var token: String {
        get {
            return string(forKey: UserDefaultKeys.token.rawValue) ?? ""
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.token.rawValue)
            synchronize()
        }
    }
    // MARK:- Model is example for inside extension but model get sets to UserDefaults can access any global codable models.
    
    func getMenuModel() -> [AnyModel]? {
        guard let menuData = data(forKey: UserDefaultKeys.anyModel.rawValue) else { return nil}
        do {
            let menuModel =  try JSONDecoder().decode([AnyModel].self, from: menuData)
            return menuModel
        } catch let decoderError {
            print("failed to decoder",decoderError)
        }
        return nil
    }
    
    func saveMenuModel(menuModel: [AnyModel]){
        do {
            let data = try JSONEncoder().encode(menuModel)
            set(data, forKey: UserDefaultKeys.anyModel.rawValue)
            synchronize()
        } catch let encodeError {
            print("Failed to encode countModel ",encodeError)
        }
    }
    
}
