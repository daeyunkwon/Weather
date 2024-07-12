//
//  Observable.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import Foundation

final class Observable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}
