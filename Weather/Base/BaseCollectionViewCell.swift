//
//  BaseCollectionViewCell.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindData()
        configureLayout()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData() { }
    
    func configureLayout() { }
    
    func configureUI() { contentView.backgroundColor = .clear }   
}
