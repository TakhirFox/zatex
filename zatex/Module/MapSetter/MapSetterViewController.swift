//
//  MapSetterMapSetterViewController.swift
//  zatex
//
//  Created by winzero on 27/07/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit
import YandexMapsMobile
import CoreLocation

protocol MapSetterViewControllerProtocol: AnyObject {
    var presenter: MapSetterPresenterProtocol? { get set }
        
    func setMapPlace(coordinates: CoordinareEntity)
    func setMapAddress(text: String)
    func showAddressList(data: [CoordinatesResult])
    func showToastMapError(text: String)
}

class MapSetterViewController: BaseViewController {
    
    var presenter: MapSetterPresenterProtocol?
    
    private var selecterCoordinates: CoordinareEntity?
    
    private var searchValue = "" {
        didSet {
            debouncer.call()
        }
    }
    
    private let locationManager = CLLocationManager()
    
    private var debouncer: Debouncer!
    private let mapView = YMKMapView()
    private var searchTextField = BaseTextField()
    private let searchResultView = SearchResultView()
    private let saveButton = BaseButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFirstParty()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupFirstParty() {
        mapView.mapWindow.map.addInputListener(with: self)
        searchTextField.delegate = self
        searchTextField.placeholder = "Найти свой адрес"
        searchResultView.isHidden = true
        debouncer = Debouncer.init(delay: 3, callback: debouncerGetAddress)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.set(style: .primary)
        saveButton.addTarget(self, action: #selector(saveAndDismiss), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(searchTextField)
        mapView.addSubview(searchResultView)
        mapView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        searchResultView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setPointOnMap() {
        mapView.mapWindow.map.mapObjects.clear()
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(
                    latitude: selecterCoordinates?.latitude ?? 0,
                    longitude: selecterCoordinates?.longitude ?? 0
                ),
                zoom: 15,
                azimuth: 0,
                tilt: 0),
            animationType: YMKAnimation(
                type: .smooth,
                duration: 1
            ),
            cameraCallback: nil
        )
        
        mapView.mapWindow.map.mapObjects.addPlacemark(
            with: YMKPoint(
                latitude: selecterCoordinates?.latitude ?? 0,
                longitude: selecterCoordinates?.longitude ?? 0
            ),
            image: UIImage(named: "pinicon")!
        )
    }
}

extension MapSetterViewController {
    
    @objc private func saveAndDismiss() {
        presenter?.goToBackWith(address: searchValue)
    }
    
    private func debouncerGetAddress() {
        presenter?.findAdress(from: searchValue)
    }
}

extension MapSetterViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != nil { 
            searchResultView.isHidden = false
            searchValue = textField.text!
            
            searchResultView.setupCell(address: [])
            searchResultView.loader(isShow: true)
        }
    }
}

extension MapSetterViewController: YMKMapInputListener {
    
    func onMapLongTap(with map: YMKMap, point: YMKPoint) {
        let coordinates = CoordinareEntity(
            latitude: point.latitude,
            longitude: point.longitude
        )
        
        selecterCoordinates = coordinates
        setPointOnMap()
        
        presenter?.getAddress(from: coordinates)
    }
    
    func onMapTap(with map: YMKMap, point: YMKPoint) {
        let coordinates = CoordinareEntity(
            latitude: point.latitude,
            longitude: point.longitude
        )
        
        selecterCoordinates = coordinates
        setPointOnMap()
        
        presenter?.getAddress(from: coordinates)
    }
}

extension MapSetterViewController: MapSetterViewControllerProtocol {

    func setMapPlace(coordinates: CoordinareEntity) {
        self.selecterCoordinates = coordinates
        self.setPointOnMap()
    }
    
    func setMapAddress(text: String) {
        searchValue = text
        searchTextField.text = text
    }
    
    func showAddressList(data: [CoordinatesResult]) {
        searchResultView.setupCell(address: data)
        
        searchResultView.tappedHandler = { [weak self] address in
            let city = address.address?.city ?? ""
            let road = address.address?.road ?? ""
            let houseNumber = address.address?.houseNumber ?? ""
            
            self?.searchTextField.text = "\(city), \(road) \(houseNumber)"
            
            let coordinate = CoordinareEntity(
                latitude: Double(address.lat ?? "") ?? 0,
                longitude: Double(address.lon ?? "") ?? 0
            )
            
            self?.searchResultView.isHidden = true
            
            self?.setMapPlace(coordinates: coordinate)
        }
        
        searchResultView.loader(isShow: false)
    }
    
    func showToastMapError(text: String) {
        toastAnimation(text: text) { }
    }
}

extension MapSetterViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first?.coordinate
        
        let coordinates = CoordinareEntity(
            latitude: location?.latitude ?? 0,
            longitude: location?.longitude ?? 0
        )
        
        presenter?.showMapPlace(coordinates: coordinates)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        toastAnimation(text: "Не удалось распознать ваше местоположение") {  [weak self] in
            self?.locationManager.requestLocation()
        }
    }
}
