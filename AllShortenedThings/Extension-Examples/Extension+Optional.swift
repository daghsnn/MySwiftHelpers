//
//  Extension+Optional.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
