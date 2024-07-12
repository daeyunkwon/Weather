//
//  MainCollectionTableViewCollectionViewCell.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

import SnapKit

final class MainTableViewThreeHoursCollectionCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    
    
    //MARK: - UI Components
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.text = "12시"
        label.textColor = Constant.Color.labelColor
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "star")
        return iv
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "8°"
        label.textColor = Constant.Color.labelColor
        return label
    }()
    
    //MARK: - Configurations
    
    override func configureLayout() {
        contentView.addSubview(hourLabel)
        hourLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(30)
        }
        
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    //MARK: - Functions
    

}
