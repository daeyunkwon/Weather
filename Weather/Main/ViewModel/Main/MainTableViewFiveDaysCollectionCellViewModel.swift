//
//  MainTableViewFiveDaysCollectionCellViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import Foundation

final class MainTableViewFiveDaysCollectionCellViewModel {
    
    //MARK: - Inputs
    
    var inputData = Observable<WeatherForecast?>(nil)
    
    //MARK: - Ouputs
    
    private(set) var outputDayOfTheWeek = Observable<String>("")
    private(set) var outputIconURL = Observable<URL?>(nil)
    private(set) var outputMinTemperature = Observable<String>("")
    private(set) var outputMaxTemperature = Observable<String>("")
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputData.bind { [weak self] list in
            guard let self else { return }
            guard let list = list else { return }
            
            self.getDayOfTheWeekFromDate(date: list.date ?? Date())
            
            self.outputIconURL.value = APIURL.iconURL(icon: list.weather.first?.icon ?? "")
            
            self.outputMinTemperature.value = "최저 \(Int(list.main.tempMin - 273.15))°"
            self.outputMaxTemperature.value = "최고 \(Int(list.main.tempMax - 273.15))°"
        }
    }
    
    //MARK: - Functions

    private func getDayOfTheWeekFromDate(date: Date) {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
        
        if calendar.isDateInToday(date) {
            self.outputDayOfTheWeek.value = "오늘"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEEEE"
            
            formatter.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
            formatter.locale = Locale(identifier: "ko_KR")
            let convertStr = formatter.string(from: date)
            
            self.outputDayOfTheWeek.value = convertStr
        }
    }
    
}
