//
//  NumbersFormats.swift
//  GreatSport
//
//  Created by mac on 7/16/23.
//


import Foundation

class NumbersFormats {

   static func formatNumber(_ numberString: String) -> String {
        guard let number = Double(numberString) else {
            return numberString
        }
        
        let abbreviatedUnits = ["k", "M", "B", "T"]
        var abbreviatedNumber = number
        var unitIndex = 0

        while abbreviatedNumber >= 1000 && unitIndex < abbreviatedUnits.count - 1 {
            abbreviatedNumber /= 1000
            unitIndex += 1
        }

        let formattedNumber = String(format: "%.1f", abbreviatedNumber)
        let unitString = abbreviatedUnits[unitIndex]

        return formattedNumber + unitString
    }


    
    
}
