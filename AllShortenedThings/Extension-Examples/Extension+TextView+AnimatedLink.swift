//
//  Extension+TextView+AnimatedLink.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 26.02.2022.
//

import UIKit

extension UITextView {
    func hyperLink(originalText: String, hyperLinks: [String], urlStrings: [String], font:UIFont, linkColor:UIColor? = nil) {
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        for i in 0..<hyperLinks.count where hyperLinks.count == urlStrings.count {
            let linkRange = attributedOriginalText.mutableString.range(of: hyperLinks[i])
            let fullRange = NSMakeRange(0, attributedOriginalText.length)
            attributedOriginalText.addAttribute(.link, value: urlStrings[i], range: linkRange)
            attributedOriginalText.addAttribute(.font, value: font, range: fullRange)
            attributedOriginalText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: linkRange)
        }
        self.tintColor = linkColor ?? .blue
        self.attributedText = attributedOriginalText
    }  
}
extension UITextField {
  func setInputViewDatePicker(target: Any,title: String, selector: Selector, pickerMode: UIDatePicker.Mode = .time, minimumDate: Date? = nil, maximumDate: Date? = nil) {
        
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = pickerMode
        let loc = Locale(identifier: "tr")
        datePicker.locale = loc
        if let minimum = minimumDate {
            datePicker.minimumDate = minimum
        }
        
        if let max = maximumDate {
            datePicker.maximumDate = max
        }
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePicker
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Kapat", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Seç", style: .plain, target: target, action: selector)
        let titleLabel = UIBarButtonItem(title: title, style: .plain, target: target, action: nil)
                
        toolBar.setItems([cancel, flexible, titleLabel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}  
