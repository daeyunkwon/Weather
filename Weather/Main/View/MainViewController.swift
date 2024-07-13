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
    
    let viewModel = MainViewModel()
    
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
    
    private let bottomBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 6/255, green: 25/255, blue: 52/255, alpha: 1)
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.alpha = 0.5
        return view
    }()
    
    private lazy var mapButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.setImage(Constant.SymbolImage.map, for: .normal)
        btn.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var listButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.setImage(Constant.SymbolImage.list, for: .normal)
        btn.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Configurations
    
    override func bindData() {
        viewModel.inputFetchData.value = ()
        
        viewModel.outputFetchDataCompletion.bind { _ in
            if self.viewModel.outputWeatherCurrentData == nil || self.viewModel.outputWeatherForecastData == nil {
                self.showNetworkFailAlert(type: .failedResponse)
            }
            self.tableView.reloadData()
        }
        
        viewModel.outputPushCitySearchVC.bind { _ in
            let vc = CitySearchViewController()
            vc.viewModel.inputFetchData.value = ()
            vc.viewModel.closureDataSendToMainVC = { [weak self] sender in
                guard let self else { return }
                self.viewModel.inputFetchDataWithSelectedCity.value = sender
            }
            self.pushViewController(vc: vc)
        }
    }
    
    override func setupNavi() {
        navigationItem.title = ""
        navigationItem.largeTitleDisplayMode = .never
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
        
        view.addSubview(bottomBackView)
        bottomBackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.frame.size.height / 10)
            make.bottom.equalToSuperview()
        }
        
        bottomBackView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.2)
        }
        
        bottomBackView.addSubview(mapButton)
        mapButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().inset(15)
            make.size.equalTo(50)
        }
        
        bottomBackView.addSubview(listButton)
        listButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(15)
            make.size.equalTo(50)
        }
    }
    
    //MARK: - Functions
    
    @objc private func mapButtonTapped() {
        print(#function)
    }

    @objc private func listButtonTapped() {
        viewModel.inputListButtonTapped.value = ()
    }

}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 270
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 270
        } else if indexPath.row == 2 {
            return 300
        } else if indexPath.row == 3 {
            return 520
        } else {
            return 400
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0: 
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionTableViewCell.identifier, for: indexPath) as? MainCollectionTableViewCell else {
                print("Failed to dequeue a MainCollectionTableViewCell. Using default UITableViewCell.")
                return UITableViewCell()
            }
            cell.cellType = .threeHours
            cell.viewModel.inputWeatherForecastData.value = viewModel.outputWeatherForecastData
            cell.selectionStyle = .none
            return cell
        
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionTableViewCell.identifier, for: indexPath) as? MainCollectionTableViewCell else {
                print("Failed to dequeue a MainCollectionTableViewCell. Using default UITableViewCell.")
                return UITableViewCell()
            }
            cell.cellType = .fiveDays
            cell.viewModel.inputWeatherForecastData.value = viewModel.outputWeatherForecastData
            cell.selectionStyle = .none
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewLocationTableCell.identifier, for: indexPath) as? MainTableViewLocationTableCell else {
                print("Failed to dequeue a MainTableViewLocationTableCell. Using default UITableViewCell.")
                return UITableViewCell()
            }
            cell.viewModel.inputData.value = viewModel.outputWeatherCurrentData
            cell.selectionStyle = .none
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionTableViewCell.identifier, for: indexPath) as? MainCollectionTableViewCell else {
                print("Failed to dequeue a MainCollectionTableViewCell. Using default UITableViewCell.")
                return UITableViewCell()
            }
            cell.cellType = .other
            cell.viewModel.inputWeatherCurrentData.value = viewModel.outputWeatherCurrentData
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainHeaderCell.identifier) as? MainHeaderCell else {
            return nil
        }
        header.viewModel.inputData.value = self.viewModel.outputWeatherCurrentData
        return header
    }
}

