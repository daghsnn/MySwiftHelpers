//
//  Extension+Shadow.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import UIKit

extension UIView {
    
    func makeShadow(color: UIColor, offSet:CGSize, radius:CGFloat, opacity:Float){
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }

}
