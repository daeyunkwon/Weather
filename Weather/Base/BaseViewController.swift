//
//  BaseViewController.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        bindData()
        configureLayout()
        configureUI()
    }
    
    func bindData() { }
    
    func configureLayout() { }
    
    func configureUI() { }
    
    func showNetworkFailAlert(type: OpenWeatherNetworkError) {
        let alert = UIAlertController(title: "시스템 오류", message: type.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        present(alert, animated: true)
    }
}
