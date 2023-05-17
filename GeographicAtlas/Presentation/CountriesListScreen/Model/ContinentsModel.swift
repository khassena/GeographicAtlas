//
//  ContinentsModel.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation

enum ContinentsModel: CaseIterable {
    case europe
    case asia
    case africa
    case oceania
    case northAmerica
    case southAmerica
    case antarctica
}

extension ContinentsModel {
    var name: String {
        switch self {
        case .europe:      return "  EUROPE"
        case .asia:        return "  ASIA"
        case .africa:    return "  AFRICA"
        case .oceania:        return "  OCENIA"
        case .northAmerica:     return "  NORTH AMERICA"
        case .southAmerica:   return "  SOUTH AMERICA"
        case .antarctica:         return "  ANTARCTICA"
        }
    }
}
