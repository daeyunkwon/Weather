//
//  BaseTableViewCell.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
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
    
    func configureUI() {
        backgroundColor = .clear
    }
}
