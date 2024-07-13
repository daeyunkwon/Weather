//
//  MainCollectionTableViewCellViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import Foundation

final class MainCollectionTableViewCellViewModel {
    
    //MARK: - Inputs
    
    var inputWeatherCurrentData = Observable<WeatherCurrent?>(nil)
    var inputWeatherForecastData = Observable<WeatherForecastResult?>(nil)
    
    //MARK: - Ouputs
    
    private(set) var outputWeatherCurrentData = Observable<WeatherCurrent?>(nil)
    
    private(set) var outputThreeHoursForecastDataList = Observable<[WeatherForecast]>([])
    private(set) var outputFiveDaysForecastDataList = Observable<[WeatherForecast]>([])
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputWeatherCurrentData.bind { data in
            self.outputWeatherCurrentData.value = data
        }
        
        inputWeatherForecastData.bind { list in
            guard let forecastDatas = list?.list else { return }
            self.classifyDataList(dataList: forecastDatas)
        }
    }
    
    //MARK: - Functions

    private func classifyDataList(dataList: [WeatherForecast]) {
        outputThreeHoursForecastDataList.value = dataList.filter {
            guard let date = $0.date else { return false }
            
            var calendar = Calendar.current
            
            calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
            
            let today = calendar.component(.day, from: Date())
            let compare = calendar.component(.day, from: date)
            
            if compare <= today + 2 {
                return true
            } else {
                return false
            }
        }
        
        
        var isFindFirst = false
        var isFindSecond = false
        var isFindThird = false
        var isFindFourth = false
        var isFindFifth = false
        
        outputFiveDaysForecastDataList.value = dataList.filter {
            guard let date = $0.date else { return false }
            let calendar = Calendar.current
            
            if date == calendar.date(byAdding: .day, value: 1, to: date) ?? Date() && isFindFirst == false {
                isFindFirst = true
                return true
            }
            
            if date == calendar.date(byAdding: .day, value: 2, to: date) ?? Date() && isFindSecond == false {
                isFindSecond = true
                return true
            }
            
            if date == calendar.date(byAdding: .day, value: 3, to: date) ?? Date() && isFindThird == false {
                isFindThird = true
                return true
            }
            
            if date == calendar.date(byAdding: .day, value: 4, to: date) ?? Date() && isFindFourth == false {
                isFindFourth = true
                return true
            }
            
            if date == calendar.date(byAdding: .day, value: 5, to: date) ?? Date() && isFindFifth == false {
                isFindFifth = true
                return true
            }
            
            return false
        }
    }
    
}
