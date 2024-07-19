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
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarTextChanged), for: .editingChanged)
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarTextFieldReturnKeyTapped), for: .editingDidEndOnExit)
        searchBar.searchTextField.autocorrectionType = .no
        searchBar.searchTextField.autocapitalizationType = .none
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.keyboardDismissMode = .onDrag
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
        viewModel.outputFilteredCityDatas.bind { [weak self] cities in
            self?.tableView.reloadData()
        }
    }
    
    override func setupNavi() {
        navigationItem.title = "City"
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
    
    @objc private func searchBarTextChanged(searchText: UITextField) {
        guard let text = searchText.text else { return }
        viewModel.inputSearchTextChanged.value = text
    }
    
    @objc private func searchBarTextFieldReturnKeyTapped() {
        self.searchBar.endEditing(true)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension CitySearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputFilteredCityDatas.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitySearchTableViewCell.identifier, for: indexPath) as? CitySearchTableViewCell else {
            print("Failed to dequeue a CitySearchTableViewCell. Using default UITableViewCell.")
            return UITableViewCell()
        }
        cell.viewModel.inputCityData.value = viewModel.outputFilteredCityDatas.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputCellSelected.value = viewModel.outputFilteredCityDatas.value[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
        self.popViewController()
    }
}
