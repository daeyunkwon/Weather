//
//  MainTableViewThreeHoursCollectionCellViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import UIKit

final class MainTableViewThreeHoursCollectionCellViewModel {
    
    
    //MARK: - Properties
    
    
    //MARK: - Inputs
    
    var inputData = Observable<WeatherForecast?>(nil)
    
    //MARK: - Ouputs
    
    var outputHour = Observable<String>("")
    var outputIconImageURL = Observable<URL?>(nil)
    var outputTemp = Observable<String>("")
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputData.bind { value in
            guard let data = value else { return }
            
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
            let hour = calendar.component(.hour, from: data.date ?? Date())
            self.outputHour.value = "\(hour)시"
            
            self.outputIconImageURL.value = APIURL.iconURL(icon: data.weather.first?.icon ?? "")
            
            let temp = Int(data.main.temp - 273.15)
            self.outputTemp.value = "\(temp)°"
        }
    }
    
}
