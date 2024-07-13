//
//  Weather.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import Foundation

struct WeatherCurrent: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let name: String
}

struct Coord: Decodable {
    let lon, lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct Clouds: Decodable {
    let all: Int
}



