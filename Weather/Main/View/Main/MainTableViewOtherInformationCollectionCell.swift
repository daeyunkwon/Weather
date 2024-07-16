//
//  MainTableViewOtherInformationCollectionCell.swift
//  Weather
//
//  Created by 권대윤 on 7/11/24.
//

import UIKit

import SnapKit

final class MainTableViewOtherInformationCollectionCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    let viewModel = MainTableViewOtherInformationCollectionCellViewModel()
    
    enum CellType {
        case wind
        case cloud
        case pressure
        case humidity
    }
    var cellType: CellType = .wind {
        didSet {
            switch cellType {
            case .wind:
                updateTitleButtonAppearance(image: Constant.SymbolImage.wind, titleText: " 바람속도")
                subInformationLabel.isHidden = false
            case .cloud:
                updateTitleButtonAppearance(image: Constant.SymbolImage.dropFill, titleText: " 구름")
                subInformationLabel.isHidden = true
            case .pressure:
                updateTitleButtonAppearance(image: Constant.SymbolImage.thermometerMedium, titleText: " 기압")
                subInformationLabel.isHidden = true
            case .humidity:
                updateTitleButtonAppearance(image: Constant.SymbolImage.humidity, titleText: " 습도")
                subInformationLabel.isHidden = true
            }
        }
    }
    
    //MARK: - UI Components
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var titleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = Constant.Color.labelColor
        btn.isUserInteractionEnabled = false
        btn.alpha = 0.5
        return btn
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.labelColor
        label.font = .systemFont(ofSize: 35)
        return label
    }()
    
    private let subInformationLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constant.Color.labelColor
        return label
    }()
    
    //MARK: - Configurations
    
    override func configureLayout() {
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(2)
            make.horizontalEdges.equalToSuperview().inset(2)
        }
        
        backView.addSubview(titleButton)
        titleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        
        backView.addSubview(informationLabel)
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
        }
        
        backView.addSubview(subInformationLabel)
        subInformationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func bindData() {
        viewModel.outputInformation.bind { [weak self] str in
            self?.informationLabel.text = str
        }
        
        viewModel.outputSubInformation.bind { [weak self] str in
            self?.subInformationLabel.text = str
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    //MARK: - Functions
    
    private func updateTitleButtonAppearance(image: UIImage?, titleText: String) {
        titleButton.setImage(image, for: .normal)
        titleButton.setTitle(titleText, for: .normal)
    }
}
