//
//  MainTableViewLocationTableCellViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import Foundation

final class MainTableViewLocationTableCellViewModel {
    
    //MARK: - Inputs
    
    var inputData = Observable<WeatherCurrent?>(nil)
    
    //MARK: - Ouputs
    
    private(set) var outputLocationData = Observable<[String: Double]>([:])
    private(set) var outputTemp: String = ""
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputData.bind { [weak self] weatherCurrent in
            guard let self else { return }
            guard let data = weatherCurrent else { return }
            
            let locationDict = ["lat": data.coord.lat, "lon": data.coord.lon]
            self.outputLocationData.value = locationDict
            
            self.outputTemp = String(Int((data.main.temp - 273.15))) + "°"
        }
    }
}
