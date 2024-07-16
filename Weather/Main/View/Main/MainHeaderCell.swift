//
//  MainHeaderCell.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

import SnapKit

final class MainHeaderCell: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    
    let viewModel = MainHeaderViewModel()
    
    //MARK: - UI Components
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 45)
        label.textColor = Constant.Color.labelColor
        label.textAlignment = .center
        return label
    }()
    
    private let mainTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 100)
        label.textColor = Constant.Color.labelColor
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.textColor = Constant.Color.labelColor
        return label
    }()
    
    private let subTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = Constant.Color.labelColor
        return label
    }()
    
    //MARK: - Configurations
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureLayout()
        contentView.backgroundColor = .clear
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.outputCityName.bind { [weak self] value in
            self?.cityNameLabel.text = value
        }
        
        viewModel.outputTemp.bind { [weak self] value in
            self?.mainTempLabel.text = value
        }
        
        viewModel.outputDescription.bind { [weak self] value in
            self?.descriptionLabel.text = value
        }
        
        viewModel.outputSubTemp.bind { [weak self] value in
            self?.subTempLabel.text = value
        }
    }
    
    private func configureLayout() {
        contentView.addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(mainTempLabel)
        mainTempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom)
            make.centerX.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTempLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(subTempLabel)
        subTempLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    func executeAnimation() {
        let duration = 0.5
        self.cityNameLabel.alpha = 0
        self.mainTempLabel.alpha = 0
        self.descriptionLabel.alpha = 0
        self.subTempLabel.alpha = 0
        
        UIView.animate(withDuration: duration, delay: 0.5) { [weak self] in
            self?.cityNameLabel.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: duration) { [weak self] in
                self?.mainTempLabel.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: duration) { [weak self] in
                    self?.descriptionLabel.alpha = 1
                } completion: { _ in
                    UIView.animate(withDuration: duration) { [weak self] in
                        self?.subTempLabel.alpha = 1
                    }
                }
            }
        }
    }
    
}
