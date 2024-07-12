//
//  MainViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import Foundation

final class MainViewModel {
    
    //MARK: - Properties
    
    private var lat = 37.583328
    private var lon  = 127.0
    
    //MARK: - Inputs
    
    var inputFetchData = Observable<Void?>(nil)
    
    //MARK: - Ouputs
    
    private(set) var outputWeatherCurrentData: Observable<WeatherCurrent?> = Observable(nil)
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputFetchData.bind { _ in
            self.fetchData()
        }
    }
    
    //MARK: - Functions

    private func fetchData() {
        NetworkManager.shared.fetchData(api: .current(lat: self.lat, lon: self.lon), model: WeatherCurrent.self) { result in
            switch result {
            case .success(let value):
                self.outputWeatherCurrentData.value = value
                
            case .failure(let error):
                self.outputWeatherCurrentData.value = nil
                print(error)
            }
        }
    }
    
}
