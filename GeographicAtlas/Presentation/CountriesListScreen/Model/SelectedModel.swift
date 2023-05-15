//
//  SelectedModel.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 15.05.2023.
//

import Foundation

enum SelectedModel {
    case selected(Index)
    case unSelected(Index)
    
    struct Index {
        var indexPath: IndexPath
    }
}
