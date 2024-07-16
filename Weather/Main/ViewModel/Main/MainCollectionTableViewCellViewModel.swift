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
        inputWeatherCurrentData.bind { [weak self] data in
            self?.outputWeatherCurrentData.value = data
        }
        
        inputWeatherForecastData.bind { [weak self] list in
            guard let forecastDatas = list?.list else { return }
            self?.classifyDataList(dataList: forecastDatas)
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
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
            
            let current = calendar.component(.day, from: date)
            
            if !isFindFirst {
                let today = calendar.date(byAdding: .day, value: 0, to: Date())
                let compare = calendar.component(.day, from: today ?? Date())
                if current == compare {
                    isFindFirst = true
                    return true
                }
            }
            
            if !isFindSecond {
                let nextDay = calendar.date(byAdding: .day, value: 1, to: Date())
                let compare = calendar.component(.day, from: nextDay ?? Date())
                if current == compare {
                    isFindSecond = true
                    return true
                }
            }
            
            if !isFindThird {
                let nextDay = calendar.date(byAdding: .day, value: 2, to: Date())
                let compare = calendar.component(.day, from: nextDay ?? Date())
                if current == compare {
                    isFindThird = true
                    return true
                }
            }
            
            if !isFindFourth {
                let nextDay = calendar.date(byAdding: .day, value: 3, to: Date())
                let compare = calendar.component(.day, from: nextDay ?? Date())
                if current == compare {
                    isFindFourth = true
                    return true
                }
            }
            
            if !isFindFifth {
                let nextDay = calendar.date(byAdding: .day, value: 4, to: Date())
                let compare = calendar.component(.day, from: nextDay ?? Date())
                if current == compare {
                    isFindFifth = true
                    return true
                }
            }
            return false
        }
    }
    
}
