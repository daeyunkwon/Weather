//
//  CitySearchTableViewCellViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/14/24.
//

import Foundation

final class CitySearchTableViewCellViewModel {
    
    //MARK: - Inputs
    
    var inputCityData = Observable<City?>(nil)
    
    //MARK: - Ouputs
    
    private(set) var outputCityName = Observable<String>("")
    private(set) var outputCountry = Observable<String>("")
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        self.inputCityData.bind { city in
            guard let data = city else { return }
            
            self.outputCountry.value = data.country
            self.outputCityName.value = data.name
        }
    }
}
