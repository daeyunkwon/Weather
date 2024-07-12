//
//  MainTableViewLocationTableCell.swift
//  Weather
//
//  Created by 권대윤 on 7/11/24.
//

import MapKit
import UIKit

import SnapKit

final class MainTableViewLocationTableCell: BaseTableViewCell {
    
    //MARK: - Properties
    
    
    
    //MARK: - UI Components
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private let titleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(Constant.SymbolImage.thermometerMedium, for: .normal)
        btn.setTitle(" 위치", for: .normal)
        btn.tintColor = Constant.Color.labelColor
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    private let mapView = MKMapView()
    
    //MARK: - Configurations
    
    override func configureLayout() {
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        backView.addSubview(titleButton)
        titleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        
        backView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    //MARK: - Functions
    

    
    
}
