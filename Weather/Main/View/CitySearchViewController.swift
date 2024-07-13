//
//  CitySearchViewController.swift
//  Weather
//
//  Created by 권대윤 on 7/14/24.
//

import UIKit

import SnapKit

final class CitySearchViewController: BaseViewController {
    
    //MARK: - Properties
    
    let viewModel = CitySearchViewModel()
    
    //MARK: - UI Components
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a city."
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        tv.register(CitySearchTableViewCell.self, forCellReuseIdentifier: CitySearchTableViewCell.identifier)
        return tv
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Configurations
    
    override func bindData() {
        viewModel.outputCityDatas.bind { cities in
            self.tableView.reloadData()
        }
    }
    
    override func setupNavi() {
        navigationItem.title = "City"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
        let right = UIBarButtonItem(image: Constant.SymbolImage.ellipsisCircle, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem = right
    }
    
    override func configureLayout() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - Functions
    
    @objc private func rightBarButtonTapped() {
        print(#function)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension CitySearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputCityDatas.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySearchTableViewCell.identifier, for: indexPath) as? CitySearchTableViewCell else {
            print("Failed to dequeue a CitySearchTableViewCell. Using default UITableViewCell.")
            return UITableViewCell()
        }
        cell.viewModel.inputCityData.value = viewModel.outputCityDatas.value[indexPath.row]
        return cell
    }
    
    
}
