//
//  MainTableViewLocationTableCell.swift
//  Weather
//
//  Created by 권대윤 on 7/11/24.
//

import MapKit
import UIKit

import SnapKit

final class MainTableViewLocationTableCell: BaseTableViewCell {
    
    //MARK: - Properties
    
    let viewModel = MainTableViewLocationTableCellViewModel()
    
    //MARK: - UI Components
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private let titleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(Constant.SymbolImage.thermometerMedium, for: .normal)
        btn.setTitle(" 위치", for: .normal)
        btn.tintColor = Constant.Color.labelColor
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    private lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.showsCompass = true
        mv.showsScale = true
        mv.showsUserLocation = true
        mv.delegate = self
        mv.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: CustomAnnotationView.identifier)
        return mv
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
        
        backView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    override func bindData() {
        viewModel.outputLocationData.bind { [weak self] location in
            guard let self else { return }
            guard let lat = location["lat"] else { return }
            guard let lon = location["lon"] else { return }
            
            if !self.mapView.annotations.isEmpty {
                self.mapView.removeAnnotations(self.mapView.annotations)
            }
            
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            self.addAnnotation(lat: lat, lon: lon)
            self.mapView.setRegion(MKCoordinateRegion(center: center, latitudinalMeters: 30000, longitudinalMeters: 30000), animated: true)
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    //MARK: - Functions
    
    private func addAnnotation(lat: Double, lon: Double) {
        let annotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
        mapView.addAnnotation(annotation)
    }
}

//MARK: - MKMapViewDelegate

extension MainTableViewLocationTableCell: MKMapViewDelegate {
    
    func setupAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        
        return mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier, for: annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        // CustomAnnotationView를 생성
        if let customAnnotation = annotation as? CustomAnnotation {
            annotationView = setupAnnotationView(for: customAnnotation, on: mapView)
            if let customView = annotationView as? CustomAnnotationView {
                customView.tempLabel.text = viewModel.outputTemp
            }
        }
        
        return annotationView
    }
}
