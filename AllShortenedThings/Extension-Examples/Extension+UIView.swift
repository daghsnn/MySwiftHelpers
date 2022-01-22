//
//  Extension+UIView.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import UIKit

extension UIView {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func viewToImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
