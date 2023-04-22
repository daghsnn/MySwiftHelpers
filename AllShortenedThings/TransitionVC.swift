//
//  TransitionVC.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 1.02.2022.
//

import UIKit

class TransitionVC:NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        //Viewlar arasi geçişin süresi için (second)
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //Çalışacak olan animasyon kodları
        
    }
    
   
    
    
}
