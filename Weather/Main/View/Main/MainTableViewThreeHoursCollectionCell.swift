//
//  MainCollectionTableViewCollectionViewCell.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

import Kingfisher
import SnapKit

final class MainTableViewThreeHoursCollectionCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    let viewModel = MainTableViewThreeHoursCollectionCellViewModel()
    
    //MARK: - UI Components
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.labelColor
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.labelColor
        return label
    }()
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
        iconImageView.image = nil
        tempLabel.text = nil
    }
    
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
            make.size.equalTo(50)
        }
        
        contentView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    override func bindData() {
        viewModel.outputHour.bind { value in
            self.hourLabel.text = value
        }
        
        viewModel.outputIconImageURL.bind { image in
            self.iconImageView.kf.setImage(with: image)
        }
        
        viewModel.outputTemp.bind { value in
            self.tempLabel.text = value
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
}
