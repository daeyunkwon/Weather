//
//  WeatherForecase.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import Foundation

struct WeatherForecastResult: Decodable {
    let cnt: Int
    let list: [WeatherForecast]
}

struct WeatherForecast: Decodable {
    let main: Main
    let weather: [Weather]
    let dateText: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case dateText = "dt_txt"
    }
    
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")

        return formatter.date(from: self.dateText)
    }
}
