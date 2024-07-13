//
//  MainCollectionTableViewCell.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

import SnapKit

final class MainCollectionTableViewCell: BaseTableViewCell {
    
    //MARK: - Properties
    
    let viewModel = MainCollectionTableViewCellViewModel()
    
    enum CellType: Int {
        case threeHours
        case fiveDays
        case other
    }
    var cellType: CellType = .other {
        didSet {
            switch cellType {
            case .threeHours:
                updateTitleButtonAppearance(image: Constant.SymbolImage.calendar, titleText: " 3시간 간격의 일기예보")
            case .fiveDays:
                updateTitleButtonAppearance(image: Constant.SymbolImage.calendar, titleText: " 5일 간의 일기예보")
            case .other:
                updateTitleButtonAppearance(image: Constant.SymbolImage.thermometerMedium, titleText: "")
            }
            
            self.configureAutoLayout()
            
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                switch cellType {
                case .threeHours: flowLayout.scrollDirection = .horizontal
                case .fiveDays, .other:
                    flowLayout.scrollDirection = .vertical
                    self.collectionView.isScrollEnabled = false
                }
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
        return btn
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.alpha = 0.5
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        
        cv.register(MainTableViewThreeHoursCollectionCell.self, forCellWithReuseIdentifier: MainTableViewThreeHoursCollectionCell.identifier)
        cv.register(MainTableViewFiveDaysCollectionCell.self, forCellWithReuseIdentifier: MainTableViewFiveDaysCollectionCell.identifier)
        cv.register(MainTableViewOtherInformationCollectionCell.self, forCellWithReuseIdentifier: MainTableViewOtherInformationCollectionCell.identifier)
        return cv
    }()
    
    //MARK: - Configurations
    
    override func bindData() {
        viewModel.outputThreeHoursForecastDataList.bind { _ in
            self.collectionView.reloadData()
        }
        
        viewModel.outputFiveDaysForecastDataList.bind { _ in
            self.collectionView.reloadData()
        }
        
        viewModel.outputWeatherCurrentData.bind { _ in
            self.collectionView.reloadData()
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
    
    private func configureAutoLayout() {
        switch cellType {
        case .threeHours, .fiveDays:
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
            
            backView.addSubview(separatorLine)
            separatorLine.snp.makeConstraints { make in
                make.top.equalTo(titleButton.snp.bottom).offset(10)
                
                switch cellType {
                case .threeHours:
                    make.leading.equalTo(titleButton.snp.leading).offset(0)
                    make.trailing.equalTo(backView.snp.trailing)
                case .fiveDays:
                    make.horizontalEdges.equalToSuperview().inset(15)
                case .other:
                    break
                }
                
                make.height.equalTo(0.2)
            }
            
            backView.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(separatorLine.snp.bottom).offset(-10)
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
        case .other:
            contentView.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MainCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case .threeHours:
            return viewModel.outputThreeHoursForecastDataList.value.count
        case .fiveDays:
            return viewModel.outputFiveDaysForecastDataList.value.count
        case .other:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch cellType {
        case .threeHours:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTableViewThreeHoursCollectionCell.identifier, for: indexPath) as? MainTableViewThreeHoursCollectionCell else {
                print("Failed to dequeue a MainCollectionTableViewCollectionell. Using default UICollectionViewCell.")
                return UICollectionViewCell()
            }
            cell.viewModel.inputData.value = viewModel.outputThreeHoursForecastDataList.value[indexPath.row]
            return cell
            
        case .fiveDays:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTableViewFiveDaysCollectionCell.identifier, for: indexPath) as? MainTableViewFiveDaysCollectionCell else {
                print("Failed to dequeue a MainCollectionTableViewCollectionell. Using default UICollectionViewCell.")
                return UICollectionViewCell()
            }
            return cell
        
        case .other:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTableViewOtherInformationCollectionCell.identifier, for: indexPath) as? MainTableViewOtherInformationCollectionCell else {
                print("Failed to dequeue a MainCollectionTableViewCollectionell. Using default UICollectionViewCell.")
                return UICollectionViewCell()
            }
            switch indexPath.item {
            case 0: cell.cellType = .wind
            case 1: cell.cellType = .cloud
            case 2: cell.cellType = .pressure
            case 3: cell.cellType = .humidity
            default: break
            }
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch cellType {
        case .threeHours:
            return CGSize(width: 60, height: 150)
            
        case .fiveDays:
            let width: Double = contentView.bounds.width - 60.0
            return CGSize(width: width, height: 60)
        
        case .other:
            let width: Double = (contentView.bounds.width + 10.0) / 2 - 20.0
            return CGSize(width: width, height: width)
        }
    }
}
