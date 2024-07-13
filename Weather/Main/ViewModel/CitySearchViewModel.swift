//
//  CitySearchViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/14/24.
//

import UIKit

final class CitySearchViewModel {
    
    //MARK: - Inputs
    
    var closureDataSendToMainVC: ((City) -> Void) = { sender in }
    
    var inputFetchData = Observable<Void?>(nil)
    
    var inputCellSelected = Observable<City?>(nil)
    
    //MARK: - Ouputs
    
    private(set) var outputCityDatas = Observable<[City]>([])
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputFetchData.bind { _ in
            self.outputCityDatas.value = self.loadJson(filename: "CityList")
        }
        
        inputCellSelected.bind { city in
            guard let data = city else { return }
            self.closureDataSendToMainVC(data)
        }
    }
    
    //MARK: - Functions

    private func loadJson(filename fileName: String) -> [City] {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([City].self, from: data)
                return jsonData
            } catch {
                print("failed loadJson error: \(error)")
            }
        }
        return []
    }
}
