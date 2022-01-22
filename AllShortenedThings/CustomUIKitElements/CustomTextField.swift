//
//  CustomTextField.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import UIKit
import SnapKit

class CustomTextField: UITextField, UITextFieldDelegate {
    
    
    var showPassword: Bool = false {
        didSet {
            self.isSecureTextEntry = showPassword
        }
    }

    var placeHolderColor : UIColor = .clear {
        didSet{
            attributedPlaceholder = NSAttributedString(string: "placeholder", attributes: [NSAttributedString.Key.foregroundColor    : placeHolderColor])
        }
    }
    
    var height: CGFloat = UIView.height * 0.06 {
        didSet {
            self.snp.remakeConstraints { (maker) in
                maker.height.equalTo(height)
            }
        }
    }
    
    var buttonsTintColor: UIColor = .darkText {
        didSet {
            leftView?.tintColor = buttonsTintColor
            rightView?.tintColor = buttonsTintColor
        }
    }
    
    var isPasswordTextField: Bool = false {
        didSet {
            self.isSecureTextEntry = isPasswordTextField
        }
    }
    
    var radius: CGFloat = 20 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
    var leftIconImg : UIImageView = .init(image: UIImage(named: "playbutton")?.withRenderingMode(.alwaysTemplate)) {
        didSet{
            self.leftView = leftIconImg
            self.leftView?.contentMode = .center
            self.leftView?.clipsToBounds = true
        }
    }
    
//    private lazy var rightIconView: UIButton = {
//        makeRightImageView()
//    }()
    
    //    var isRightButttonActive: Bool = false {
    //        didSet {
    //            rightIconView = makeRightImageView()
    //            rightView = rightIconView
    //            self.rightViewMode = isRightButttonActive ? .always : .never
    //
    //            rightView?.setNeedsDisplay()
    //        }
    //    }
        
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.leftViewMode = .always
        self.isSecureTextEntry = showPassword
        self.clipsToBounds = true
//        self.rightViewMode = .always
        self.leftView = leftIconImg
//        self.rightView = rightIconView
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        guard let leftViewWidth = self.leftView?.bounds.width else {return CGRect(x: self.radius, y: 0, width: bounds.width, height: self.height)}
        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftViewWidth + 10 + self.radius, bottom: 0, right: 10))
    }
    
    func textShadow(shadowColor: UIColor, shadowOffSet:CGSize, shadowRadius:CGFloat, shadowOpacity:Float){
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffSet
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }
    
    private func makeLeftImageView(for imageName: String) -> UIImageView {
        let icon = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .center
        imageView.tintColor = buttonsTintColor
        return imageView
    }
    
//    private func makeRightImageView() -> UIButton {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "eye"), for: .normal)
//        button.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
//        button.tintColor = .white
//        return button
//    }
//
//    @objc private func eyeButtonTapped() {
//        self.showPassword.toggle()
//        self.showPassword ? rightIconView.setImage(UIImage(systemName: "eye.slash"), for: .normal) : rightIconView.setImage(UIImage(systemName: "eye"), for: .normal)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let centeredY = self.height / 2
        let leftViewBounds = CGRect(x: self.radius, y: centeredY / 2, width: self.height / 2, height: self.height / 2)
        return leftViewBounds
    }
    
//    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
//        let rightViewBounds = CGRect(x: bounds.width - 80, y: 0, width: 80, height: bounds.height)
//        return rightViewBounds
//    }
}
