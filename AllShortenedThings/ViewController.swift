//
//  ViewController.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import UIKit
import StoreKit
import Alamofire

class ViewController: UIViewController {
    
    var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.color = .white
        activity.hidesWhenStopped = true        
        return activity
    }()
    
    var textFiedl : CustomTextField = {
        let text = CustomTextField(frame: .zero)
        text.height = UIView.height * 0.05
        text.backgroundColor = .gray
        text.placeHolderColor = .yellow
        text.textColor = .yellow
        text.placeholder = "Place Holder"
        text.buttonsTintColor = .white
        text.radius = 20
        text.text = "Lorem 123"
     //   text.adjustsFontForContentSizeCategory = true // auto height responsive making
        text.isPasswordTextField = false
        text.makeShadow(color: .green, offSet: .init(width: 0, height: 20), radius: 50, opacity: 0.5)
//        text.leftIconImg = .init(image: UIImage.init(systemName: "heart"))
        return text
    }()
    
    lazy var button = UIButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let apiKeyHidden = Bundle.main.object(forInfoDictionaryKey: "ApiKey")
//        print(apiKeyHidden as Any)
        self.view.addSubview(textFiedl)
        self.view.addSubview(button)
        self.view.addSubview(activityIndicator)
        
        textFiedl.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalTo(UIView.width * 0.5)
        }
        
        activityIndicator.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        button.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(150)
            maker.leading.trailing.equalToSuperview().inset(75)
            maker.height.equalTo(50)
        }
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.activityIndicator.stopAnimating()
        }
        
        button.backgroundColor = .black
        button.setTitle("tikla", for: .normal)
        button.addTarget(self, action: #selector(tappedAnimation), for: .touchUpInside)
        guard let textWidth = textFiedl.text?.widthOfString(usingFont:.italicSystemFont(ofSize: 12)) else { return }
        print(textWidth,": text width")
    }
    
    @objc func tappedAnimation(){

        let trans = CGAffineTransform(scaleX: 2, y: 3)
        let scale = CGAffineTransform(rotationAngle: .pi / 8)
        let other = CGAffineTransform(translationX: -50, y: 100)
        
        textFiedl.transform = trans.concatenating(scale.concatenating(other))
        let animation = CABasicAnimation()
        animation.keyPath = "transform"
        animation.duration = 3
        animation.speed = 10
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        textFiedl.layer.add(animation, forKey: "anima")
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
        // load splash screen ile kaybolup geri gelme animasyonlarını yapmak için will appearda kaybedip x i did apperarde getirilebilir
//        UIView.animate(withDuration: 1.0) {
//                  self.textFiedl.center.x += self.view.bounds.width
//              }
//

//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        textFiedl.center.x -= self.view.bounds.width
//
//    }
    override func loadView() {
        super.loadView()
        // Change VC view to new view mostly using loadView
        
        // view = CustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        struct response:Codable {
            let name:String?
        }
        
        let servis = BaseService<emptyRequestModel, response>()
        servis.method = .delete
        servis.encoding = URLEncoding.httpBody
        servis.path = "somepath"
        servis.header = HTTPHeaders([HTTPHeader(name: "Token", value: "Header base servis ekleme test")])
        
        print(servis.apiKey,"\n",
              servis.baseUrl,"\n",
              servis.method,"\n",
              servis.encoding,"\n",
              servis.path,"\n",
              servis.header
        )
    }
}


