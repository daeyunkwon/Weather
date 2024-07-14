//
//  File.swift
//  Weather
//
//  Created by 권대윤 on 7/13/24.
//

import UIKit
import MapKit

import SnapKit

final class CustomAnnotationView: MKAnnotationView {
    
    //MARK: - UI Components
    
    private var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "현재 위치"
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        return label
    }()
    
    private var strokeTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "현재 위치", attributes: [.strokeColor: UIColor.systemBackground, .strokeWidth: 2, .font: UIFont.systemFont(ofSize: 15, weight: .heavy)])
        return label
    }()
    
    //MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tempLabel.text = nil
    }
    
    //MARK: - Init
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        
        self.addSubview(backView)
        
        backView.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.center.equalToSuperview()
        }
        
        backView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(0)
            make.centerX.equalTo(backView.snp.centerX)
        }
        
        self.addSubview(strokeTitleLabel)
        strokeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(0)
            make.centerX.equalTo(backView.snp.centerX)
        }
    }
}
