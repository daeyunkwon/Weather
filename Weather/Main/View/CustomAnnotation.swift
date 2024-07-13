//
//  File.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import MapKit

final class CustomAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
