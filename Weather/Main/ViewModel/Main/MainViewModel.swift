//
//  MainViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import Foundation

final class MainViewModel {
    
    //MARK: - Inputs
    
    var inputFetchData = Observable<Void?>(nil)
    
    var inputListButtonTapped = Observable<Void?>(nil)
    var inputMapButtonTapped = Observable<Void?>(nil)
    
    var inputFetchDataWithSelectedCity = Observable<City?>(nil)
    
    var inputFetchDataWithCoordinate = Observable<[Double]>([])
    
    //MARK: - Ouputs
    
    private(set) var outputWeatherCurrentData: WeatherCurrent?
    private(set) var outputWeatherForecastData: WeatherForecastResult?
    private(set) var outputFetchDataCompletion = Observable<Bool>(false)
    private(set) var outputPushCitySearchVC = Observable<Void?>(nil)
    private(set) var outputPresentMapVC = Observable<Void?>(nil)
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputFetchData.bind { [weak self] _ in
            self?.fetchData(lat: 37.583328, lon: 127.0) //Seoul
        }
        
        inputListButtonTapped.bind { [weak self] _ in
            self?.outputPushCitySearchVC.value = ()
        }
        
        inputMapButtonTapped.bind { [weak self] _ in
            self?.outputPresentMapVC.value = ()
        }
        
        inputFetchDataWithSelectedCity.bind { [weak self] city in
            guard let data = city else { return }
            self?.fetchData(lat: data.coord.lat, lon: data.coord.lon)
        }
        
        inputFetchDataWithCoordinate.bind { [weak self] values in
            if values.count == 2 {
                self?.fetchData(lat: values[0], lon: values[1])
            }
        }
    }
    
    //MARK: - Functions

    private func fetchData(lat: Double, lon: Double) {
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.fetchData(api: .current(lat: lat, lon: lon), model: WeatherCurrent.self) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.outputWeatherCurrentData = value
                    group.leave()
                    
                case .failure(let error):
                    self?.outputWeatherCurrentData = nil
                    print(error)
                    group.leave()
                }
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.fetchData(api: .forecast(lat: lat, lon: lon), model: WeatherForecastResult.self) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.outputWeatherForecastData = value
                    group.leave()
                    
                case .failure(let error):
                    self?.outputWeatherForecastData = nil
                    print(error)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.outputFetchDataCompletion.value = true
        }
    }
    
}
