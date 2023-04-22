//
//  Extension+AppDelegate.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import UIKit
import IQKeyboardManagerSwift

/* For make IQKeyboard to all project auto and call the func in app delegate */
extension AppDelegate {
    
    func configureIQKeyboardManager(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
//        IQKeyboardManager.shared.keyboardDistanceFromTextField = 10.0
        
        
    }
}
