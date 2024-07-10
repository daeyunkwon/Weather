//
//  OpenWeatherAPI.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import Foundation

import Alamofire

enum OpenWeatherAPI {
    
    case current(lat: Double, lon: Double)
    case forecast(lat: Double, lon: Double)
    
    
    var baseURL: String {
        return APIURL.baseURL
    }
    
    var endpoint: URL? {
        switch self {
        case .current:
            guard let url = URL(string: baseURL + "weather") else { return nil }
            return url
        
        case .forecast:
            guard let url = URL(string: baseURL + "forecast") else { return nil }
            return url
        }
    }
    
    var paramters: Parameters {
        switch self {
        case .current(let lat, let lon):
            return [ "lat": String(lat),
                     "lon": String(lon),
                     "appid": APIKey.apiKey ]
        
        case .forecast(let lat, let lon):
            return [ "lat": String(lat),
                     "lon": String(lon),
                     "appid": APIKey.apiKey ]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: URLEncoding {
        return .queryString
    }   
}
