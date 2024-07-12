//
//  ViewController.swift
//  Weather
//
//  Created by 권대윤 on 7/10/24.
//

import UIKit

import SnapKit

final class MainViewController: BaseViewController {

    //MARK: - Properties
    
    
    
    //MARK: - UI Components
    
    private let backView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemBlue.withAlphaComponent(0.3)
        return iv
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.delegate = self
        tv.dataSource = self
        tv.register(MainHeaderCell.self, forHeaderFooterViewReuseIdentifier: MainHeaderCell.identifier)
        tv.register(MainCollectionTableViewCell.self, forCellReuseIdentifier: MainCollectionTableViewCell.identifier)
        tv.register(MainTableViewLocationTableCell.self, forCellReuseIdentifier: MainTableViewLocationTableCell.identifier)
        return tv
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Configurations
    
    override func bindData() {
        
    }
    
    override func configureLayout() {
        view.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    //MARK: - Functions
    



}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionTableViewCell.identifier, for: indexPath) as? MainCollectionTableViewCell else {
            print("Failed to dequeue a MainCollectionTableViewCell. Using default UITableViewCell.")
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainHeaderCell.identifier) else {
            return nil
        }
        
        return header
    }
}

