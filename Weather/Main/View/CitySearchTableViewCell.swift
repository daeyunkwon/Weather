//
//  CitySearchTableViewCell.swift
//  Weather
//
//  Created by 권대윤 on 7/14/24.
//

import UIKit

import SnapKit

final class CitySearchTableViewCell: BaseTableViewCell {
    
    //MARK: - Properties
    
    let viewModel = CitySearchTableViewCellViewModel()
    
    //MARK: - UI Components
    
    private let hashtagLabel: UILabel = {
        let label = UILabel()
        label.text = "#"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        return label
    }()
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        subTitleLabel.text = ""
    }
    
    //MARK: - Configurations
    
    override func configureLayout() {
        contentView.addSubview(hashtagLabel)
        hashtagLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(hashtagLabel.snp.top).offset(5)
            make.leading.equalTo(hashtagLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func bindData() {
        viewModel.outputCityName.bind { str in
            self.titleLabel.text = str
        }
        
        viewModel.outputCountry.bind { str in
            self.subTitleLabel.text = str
        }
    }
}
