//
//  MovingObjectExample.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 16.12.2021.
//

import UIKit

private class MovingObjectExample: UIViewController {
    
    var myView = UIView()
    var animator = UIViewPropertyAnimator()
    
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handlePan(recognizer:)))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        myView.addGestureRecognizer(panRecognizer)
    }
    
    func setup() {
        view.backgroundColor = .white
        
    }
    
    func layout() {
        myView = makeView()
        view.addSubview(myView)
        
        myView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.height.equalTo(UIView.height * 0.1)
        }
    }
    
    func makeView() -> UIView {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .systemBlue
        
        return myView
    }
    
    var initialCenter = CGPoint()  // The initial center point of the view.
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let piece = recognizer.view else { return }
        
        let translation = recognizer.translation(in: piece.superview)
        let velocity = recognizer.velocity(in: piece.superview)
        
        switch recognizer.state {
        case .began:
            print("began translation:\(translation) \(velocity)")
            self.initialCenter = piece.center
        case .changed:
            print("changed translation:\(translation) \(velocity)")
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
        case .ended:
            print("ended translation:\(translation) \(velocity)")
        default:
            print("default")
        }
    }
}
