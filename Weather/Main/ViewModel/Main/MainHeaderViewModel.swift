//
//  MainHeaderViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import Foundation

final class MainHeaderViewModel {
    
    //MARK: - Inputs
    
    var inputData = Observable<WeatherCurrent?>(nil)
    
    //MARK: - Outputs
    
    private(set) var outputData = Observable<WeatherCurrent?>(nil)
    private(set) var outputCityName = Observable<String?>(nil)
    private(set) var outputTemp = Observable<String>("")
    private(set) var outputDescription = Observable<String>("")
    private(set) var outputSubTemp = Observable<String>("")
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputData.bind { [weak self] weather in
            guard let self else { return }
            guard let data = weather else { return }
            self.outputCityName.value = data.name
            self.outputTemp.value = self.convertTempString(temp: data.main.temp, decimalCount: 2)
            self.outputDescription.value = data.weather.first?.main ?? ""
            
            let tempMax = self.convertTempString(temp: data.main.tempMax, decimalCount: 1)
            let tempMin = self.convertTempString(temp: data.main.tempMin, decimalCount: 1)
            self.outputSubTemp.value = "최고: \(tempMax)  |  최저: \(tempMin)"
        }
    }
    
    //MARK: - Functions
    
    private func convertTempString(temp: Double, decimalCount: Int) -> String {
        let value = temp - 273.15
        let result = String(format: "%.\(decimalCount)f", value) + "°"
        return result
    }
    
}
