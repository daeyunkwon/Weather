//
//  MapViewModel.swift
//  Weather
//
//  Created by 권대윤 on 7/14/24.
//

import Foundation

final class MapViewModel {
    
    //MARK: - Properties
    
    private var lat: Double?
    private var lon: Double?
    
    var closureDataSendToMainVC: (Double, Double) -> Void = { lat, lon in }
    
    //MARK: - Inputs
    
    var inputAnnotationSelected = Observable<[Double]>([])
    
    var inputFetchWeatherCheckAlertOkAction = Observable<Void?>(nil)
    
    var inputXmarkButtonTapped = Observable<Void?>(nil)
    
    //MARK: - Ouputs
    
    private(set) var outputFetchWeatherCheckAlertOkAction = Observable<Void?>(nil)
    
    private(set) var outputXmarkButtonTapped = Observable<Void?>(nil)
    
    //MARK: - Init
    
    init() {
        transform()
    }
    
    private func transform() {
        inputAnnotationSelected.bind { [weak self] value in
            if value.count == 2 {
                self?.lat = value[0]
                self?.lon = value[1]
            }
        }
        
        inputFetchWeatherCheckAlertOkAction.bind { [weak self] _ in
            guard let self else { return }
            guard let lat = self.lat,
                  let lon = self.lon else { return }
            self.closureDataSendToMainVC(lat, lon)
            self.outputFetchWeatherCheckAlertOkAction.value = ()
        }
        
        inputXmarkButtonTapped.bind { _ in
            self.outputXmarkButtonTapped.value = ()
        }
    }
    
}
