//
//  Extension+UIDevice.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import UIKit

extension UIDevice {

    static let is_iPad = UIDevice.current.userInterfaceIdiom == .pad
    static let is_iPhone = UIDevice.current.userInterfaceIdiom == .phone
    
}
