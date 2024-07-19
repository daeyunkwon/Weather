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
    private(set) var outputFiveDaysForecastDataList = Observable<[[WeatherForecast]]>([])
    
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
        classifyForThreeHours(dataList)
        classifyForFiveDays(dataList)
    }
    
    private func classifyForThreeHours(_ dataList: [WeatherForecast]) {
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
    }
    
    private func classifyForFiveDays(_ dataList: [WeatherForecast]) {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
        
        var temp: [WeatherForecast] = []
        var index = 0
        for data in dataList {
            let current = calendar.component(.day, from: data.date ?? Date())
            
            var today = calendar.date(byAdding: .day, value: index, to: Date()) //index 0: 오늘, 1: 1일뒤, 2: 2일뒤, 3: 3일뒤, 4: 4일뒤
            var compare = calendar.component(.day, from: today ?? Date())
            
            if current == compare { //같은 날짜인 경우
                temp.append(data)
                if data.dateText == dataList.last?.dateText {
                    outputFiveDaysForecastDataList.value.append(temp)
                    break
                }
                continue
            } else { //같은 날짜가 아닌 경우
                outputFiveDaysForecastDataList.value.append(temp)
                temp = []
                index += 1
            }
            
            today = calendar.date(byAdding: .day, value: index, to: Date())
            compare = calendar.component(.day, from: today ?? Date())
            
            if current == compare {
                temp.append(data)
            }
        }
    }
    
}
