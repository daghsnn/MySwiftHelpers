//
//  Extension+ComputedProp.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//


// MARK:- Extension to double prophertys
extension Double {
   var km: Double { return self * 1_000.0 }
   var m: Double { return self }
   var cm: Double { return self / 100.0 }
   var mm: Double { return self / 1_000.0 }
   var ft: Double { return self / 3.28084 }
}
