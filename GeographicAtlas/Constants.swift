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
        static let heightDivision = CGFloat(4.46428571)
        static let expandedMardins = CGFloat(24)
        static let animationDuration = CGFloat(0.3)
    }
    
    struct Numbers {
        static let millionCGFloat = CGFloat(1_000_000)
        static let millionInt = Int(1000000)
        static let three = Int(3)
        static let thousand = CGFloat(1000)
        static let rotationNum = CGFloat(-0.999)
    }
}
