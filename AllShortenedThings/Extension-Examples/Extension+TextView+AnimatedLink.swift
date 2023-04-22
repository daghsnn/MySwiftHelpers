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
