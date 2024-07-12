//
//  MainTableViewFiveDaysCollectionCell.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

import SnapKit

final class MainTableViewFiveDaysCollectionCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    
    
    //MARK: - UI Components
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private let dayOfTheWeekLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.textColor = Constant.Color.labelColor
        label.text = "오늘"
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "star")
        return iv
    }()
    
    private let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.textColor = .gray
        label.text = "최저 -2°"
        return label
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.textColor = Constant.Color.labelColor
        label.text = "최고 15°"
        return label
    }()
    
    //MARK: - Configurations
    
    override func configureLayout() {
        
        contentView.addSubview(dayOfTheWeekLabel)
        dayOfTheWeekLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(40)
        }
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(dayOfTheWeekLabel.snp.trailing).offset(20)
            make.size.equalTo(40)
        }
        
        contentView.addSubview(minTemperatureLabel)
        minTemperatureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
        }
        
        contentView.addSubview(maxTemperatureLabel)
        maxTemperatureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        contentView.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.2)
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    //MARK: - Functions
    
    
    
}
