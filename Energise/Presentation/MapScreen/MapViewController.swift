//
//  MapViewController.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import UIKit

class MapViewController: UIViewController {
    // - MARK: private
    private let mapView = MapView()
    private let mapModel = MapModel()

    // - MARK: lifecycle
    override func loadView() {
        super.loadView()
        view = mapView
        mapView.delegate = self
        mapModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      getPlaces()
    }
}

private extension MapViewController {
    func getPlaces() {
        mapModel.getPlaces()
    }
}

// - MARK:  MapViewProtocol
extension MapViewController: MapViewProtocol {
    
}

// - MARK:  MapModelProtocol
extension MapViewController: MapModelProtocol {
    func show(places: [ResponseModel]) {
        mapView.show(places: places)
    }
}
