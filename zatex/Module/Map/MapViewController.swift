//
//  MapMapViewController.swift
//  zatex
//
//  Created by iamtheorangefox@gmail.com on 02/04/2023.
//  Copyright © 2023 zakirovweb. All rights reserved.
//

import UIKit
import YandexMapsMobile

protocol MapViewControllerProtocol: AnyObject {
    var presenter: MapPresenterProtocol? { get set }
    
    func showMapPlace()
    
    func setMapPlace(coordinates: CoordinareEntity)
}

class MapViewController: BaseViewController {
    
    var presenter: MapPresenterProtocol?
    
    var coordinates: CoordinareEntity?
    
    let mapView = YMKMapView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            self.tabBarController?.tabBar.frame.origin.y += 100
        }
        
        presenter?.showMapPlace()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn) {
            self.tabBarController?.tabBar.frame.origin.y -= 100
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(mapView)
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCoordinates() {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(
                    latitude: coordinates?.latitude ?? 0,
                    longitude: coordinates?.longitude ?? 0
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
                latitude: coordinates?.latitude ?? 0,
                longitude: coordinates?.longitude ?? 0
            ),
            image: UIImage(named: "pinicon")!
        )
    }
}

extension MapViewController: MapViewControllerProtocol {
    
    func showMapPlace() {
        presenter?.showMapPlace()
    }
    
    func setMapPlace(coordinates: CoordinareEntity) {
        self.coordinates = coordinates
        self.setupCoordinates()
    }
}
