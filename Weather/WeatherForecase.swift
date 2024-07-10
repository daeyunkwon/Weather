//
//  WeatherForecase.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import Foundation

struct WeatherForecaseResult: Decodable {
    let cnt: Int
    let list: [WeatherForecase]
}

struct WeatherForecase: Decodable {
    let main: Main
    let weather: [Weather]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case date = "dt_txt"
    }
}
