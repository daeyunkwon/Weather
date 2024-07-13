//
//  MainTableViewOtherInformationCollectionCellViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import Foundation

final class MainTableViewOtherInformationCollectionCellViewModel {

    //MARK: - Properties

    enum CellType {
        case wind
        case cloud
        case pressure
        case humidity
    }
    var cellType: CellType = .wind
    
    //MARK: - Inputs
    
    var inputData = Observable<WeatherCurrent?>(nil)
    
    //MARK: - Ouputs

    var outputInformation = Observable<String>("")
    var outputSubInformation = Observable<String>("")
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputData.bind { weatherCurrent in
            guard let data = weatherCurrent else { return }
            
            switch self.cellType {
            case .wind:
                self.outputInformation.value = "\(data.wind.speed)m/s"
                if let gust = data.wind.gust {
                    self.outputSubInformation.value = "강풍: \(gust)m/s"
                }
                
            case .cloud:
                self.outputInformation.value = "\(data.clouds.all)%"
            case .pressure:
                self.outputInformation.value = "\(data.main.pressure.formatted())"
            case .humidity:
                self.outputInformation.value = "\(data.main.humidity)%"
            }
            
            
        }
    }
    
}
