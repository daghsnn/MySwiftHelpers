//
//  CameraPredictionVC.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 28.12.2021.
//

import UIKit

final class CameraPredictionVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        view = CameraPredictionView()
    }
    
}

