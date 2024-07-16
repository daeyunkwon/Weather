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
    
    var inputSearchTextChanged = Observable<String>("")
    
    //MARK: - Ouputs
    
    private(set) var outputCityDatas: [City] = []
    
    private(set) var outputFilteredCityDatas = Observable<[City]>([])
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputFetchData.bind { [weak self] _ in
            guard let self else { return }
            self.outputCityDatas = self.loadJson(filename: "CityList")
            self.outputFilteredCityDatas.value = self.outputCityDatas
        }
        
        inputCellSelected.bind { [weak self] city in
            guard let data = city else { return }
            self?.closureDataSendToMainVC(data)
        }
        
        inputSearchTextChanged.bind { [weak self] text in
            guard let self else { return }
            if text.trimmingCharacters(in: .whitespaces).isEmpty {
                self.outputFilteredCityDatas.value = self.outputCityDatas
            } else {
                self.outputFilteredCityDatas.value = self.outputCityDatas.filter {
                    $0.name.lowercased().contains(text.lowercased())
                }
            }
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
