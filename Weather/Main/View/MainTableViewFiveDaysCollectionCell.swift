//
//  MainTableViewFiveDaysCollectionCell.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

import Kingfisher
import SnapKit

final class MainTableViewFiveDaysCollectionCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    let viewModel = MainTableViewFiveDaysCollectionCellViewModel()
    
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
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.textColor = .gray
        return label
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.textColor = Constant.Color.labelColor
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
    
    override func bindData() {
        viewModel.outputDayOfTheWeek.bind { value in
            self.dayOfTheWeekLabel.text = value
        }
        
        viewModel.outputIconURL.bind { url in
            self.iconImageView.kf.setImage(with: url)
        }
        
        viewModel.outputMinTemperature.bind { value in
            self.minTemperatureLabel.text = value
        }
        
        viewModel.outputMaxTemperature.bind { value in
            self.maxTemperatureLabel.text = value
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
}
