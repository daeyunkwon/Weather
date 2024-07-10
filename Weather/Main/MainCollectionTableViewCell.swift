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
    
    enum CellType: Int {
        case threeHours
        case fiveDays
    }
    var cellType: CellType = .fiveDays
    
    //MARK: - UI Components
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var titleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "calendar")?.applyingSymbolConfiguration(.init(font: UIFont.systemFont(ofSize: 12))), for: .normal)
        switch cellType {
        case .threeHours:
            btn.setTitle(" 3시간 간격의 일기예보", for: .normal)
        case .fiveDays:
            btn.setTitle(" 5일 간의 일기예보", for: .normal)
        }
        btn.tintColor = Constant.Color.labelColor
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        switch cellType {
        case .threeHours: layout.scrollDirection = .horizontal
        case .fiveDays: layout.scrollDirection = .vertical
        }
        
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(MainTableViewThreeHoursCollectionCell.self, forCellWithReuseIdentifier: MainTableViewThreeHoursCollectionCell.identifier)
        cv.register(MainTableViewFiveDaysCollectionCell.self, forCellWithReuseIdentifier: MainTableViewFiveDaysCollectionCell.identifier)
        return cv
    }()
    
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
        
        backView.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            
            switch cellType {
            case .threeHours:
                make.leading.equalTo(titleButton.snp.leading).offset(15)
                make.trailing.equalTo(backView.snp.trailing)
            case .fiveDays:
                make.horizontalEdges.equalToSuperview().inset(15)
            }
            
            make.height.equalTo(0.2)
        }
        
        backView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(-10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    //MARK: - Functions
    
    
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MainCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch cellType {
        case .threeHours:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTableViewThreeHoursCollectionCell.identifier, for: indexPath) as? MainTableViewThreeHoursCollectionCell else {
                print("Failed to dequeue a MainCollectionTableViewCollectionell. Using default UICollectionViewCell.")
                return UICollectionViewCell()
            }
            return cell
            
        case .fiveDays:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTableViewFiveDaysCollectionCell.identifier, for: indexPath) as? MainTableViewFiveDaysCollectionCell else {
                print("Failed to dequeue a MainCollectionTableViewCollectionell. Using default UICollectionViewCell.")
                return UICollectionViewCell()
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
            let width: Double = 80
            return CGSize(width: width, height: width * 2)
            
        case .fiveDays:
            let width: Double = contentView.bounds.width - 60.0
            return CGSize(width: width, height: 60)
        }
    }
}
