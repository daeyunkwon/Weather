//
//  MapViewController.swift
//  Weather
//
//  Created by 권대윤 on 7/14/24.
//

import MapKit
import UIKit

import SnapKit

final class MapViewController: BaseViewController {
    
    //MARK: - Properties
    
    private let locationManager = CLLocationManager()
    
    let viewModel = MapViewModel()
    
    //MARK: - UI Components
    
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.delegate = self
        return mv
    }()
    
    private lazy var xmarkButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(Constant.SymbolImage.xmark?.applyingSymbolConfiguration(.init(font: .systemFont(ofSize: 20), scale: .large)), for: .normal)
        btn.tintColor = .label
        btn.addTarget(self, action: #selector(xmarkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        setupGesture()
    }
    
    //MARK: - Configurations
    
    override func bindData() {
        viewModel.outputFetchWeatherCheckAlertOkAction.bind { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        viewModel.outputXmarkButtonTapped.bind { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getCoordinate))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func configureLayout() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(xmarkButton)
        xmarkButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.size.equalTo(30)
        }
    }
    
    //MARK: - Functions
    
    @objc private func getCoordinate(_ tapGesture: UITapGestureRecognizer) {
        let touchPoint = tapGesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        self.addAnnotation(latitude: coordinate.latitude, longitude: coordinate.longitude, title: "")
    }
    
    @objc private func xmarkButtonTapped() {
        viewModel.inputXmarkButtonTapped.value = ()
    }
    
    private func addAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = center
        
        self.mapView.addAnnotation(annotation)
    }
    
    private func checkDeviceLocationServiceEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let status: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    status = self.locationManager.authorizationStatus
                } else {
                    status = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: status)
                }
            } else {
                DispatchQueue.main.async {
                    self.showLocationSettingAlert()
                }
            }
        }
    }
    
    private func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            showLocationSettingAlert()
            self.addAnnotation(latitude: 37.6543567, longitude: 127.0497781, title: "도봉 캠퍼스")
            self.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.6543567, longitude: 127.0497781), latitudinalMeters: 3000, longitudinalMeters: 3000), animated: true)
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print("Error:", #function)
        }
    }
    
    private func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.(필수권한)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default, handler: { goSettingAction in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }))
        present(alert, animated: true)
    }
    
    private func showFetchWeatherCheckAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "선택한 위치의 날씨 정보를 조회하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { cancelAction in
            self.mapView.deselectAnnotation(nil, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "조회하기", style: .default, handler: { okAction in
            self.viewModel.inputFetchWeatherCheckAlertOkAction.value = ()
        }))
        present(alert, animated: true)
    }
}

//MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            self.addAnnotation(latitude: coordinate.latitude, longitude: coordinate.longitude, title: "현재 위치")
            self.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), latitudinalMeters: 3000, longitudinalMeters: 3000), animated: true)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.checkDeviceLocationServiceEnabled() //iOS14 이상
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.checkDeviceLocationServiceEnabled() //iOS14 미만
    }
}

//MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
        viewModel.inputAnnotationSelected.value = [annotation.coordinate.latitude, annotation.coordinate.longitude]
        self.showFetchWeatherCheckAlert()
    }
}
