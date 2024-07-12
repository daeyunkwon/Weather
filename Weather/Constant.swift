//
//  Constant.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

enum Constant {
    
    enum Color {
        static let labelColor = UIColor.white
    }
    
    enum SymbolImage {
        static let calendar = UIImage(systemName: "calendar")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 12)))
        static let thermometerMedium = UIImage(systemName: "thermometer.medium")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 12)))
        static let wind = UIImage(systemName: "wind")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 12)))
        static let dropFill = UIImage(systemName: "drop.fill")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 12)))
        static let humidity = UIImage(systemName: "humidity")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 12)))
        static let map = UIImage(systemName: "map")
        static let list = UIImage(systemName: "list.bullet")
    }
}
