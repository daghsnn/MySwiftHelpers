//
//  Extension+String-DoLocalizedString.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 5.03.2022.
//

import Foundation

extension String{
    
    func localizedString() -> Self {
        // Table Name is bundle .strings refered with written values
        /// exp:- "well" = "WellCome";  , "well" = "Hoş Geldiniz";
        /// using label.text = "well".localizedString
        return NSLocalizedString(self, tableName: "Localized", bundle: .main, value: self, comment: self)
    }
    
}
