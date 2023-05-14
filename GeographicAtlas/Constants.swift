//
//  Constants.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit

struct Constants {
    struct API {
        static let baseURL = "https://restcountries.com/v3.1/"
    }
    
    struct Color {
        static let backgroundGray = UIColor(red: 0.969, green: 0.973, blue: 0.976, alpha: 1)
        static let boldBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        static let gray = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        static let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        static let blueButton = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
    }
    
    struct Countries {
        static let imageCornerRadius = CGFloat(12)
    }
    
    struct TableView {
        static let heightDivision = CGFloat(4.76)
    }
}
