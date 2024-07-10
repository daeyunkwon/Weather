//
//  NetworkManager.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import Foundation

import Alamofire

enum OpenWeatherNetworkError: Error {
    case failedCreateURL
    case failedResponse
    
    var message: String {
        switch self {
        case .failedCreateURL:
            return "유효하지 않은 URL 주소로 접근하였습니다. 잠시 후 다시 시도해주세요."
        case .failedResponse:
            return "오류가 발생하여 네트워크 통신이 실패되었습니다. 잠시 후 다시 시도해주세요."
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    
    func fetchData<T: Decodable>(api: OpenWeatherAPI, model: T.Type, completionHandler: @escaping (Result<T, OpenWeatherNetworkError>) -> Void) {
        
        guard let safeURL = api.endpoint else {
            completionHandler(.failure(.failedCreateURL))
            return
        }
        
        AF.request(safeURL, method: api.method, parameters: api.paramters, encoding: api.encoding).responseDecodable(of: T.self) { response in
            switch response.result {
                
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                print(error)
                completionHandler(.failure(.failedResponse))
            }
        }
    }
}
