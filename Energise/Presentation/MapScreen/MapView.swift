//
//  MapUIView.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import Foundation
import MapKit
import UIKit

protocol MapViewProtocol: AnyObject {
//    func onButtonTap(action: ButtonViewAction)
}

enum MapViewAction {
//    case play
//    case pause
}

final class MapView: UIView {
    // - MARK: views
   private lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = InsetLabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.backgroundColor = .blue
        label.textColor = .white
        label.text = "00:00:00"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    // - MARK: internal
    weak var delegate: MapViewProtocol?

    // - MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(places: [ResponseModel]) {
        for place in places {
            showDetails(of: place)
            showOnMap(place: place)
        }
    }    
}

private extension MapView {
    func showOnMap(place: ResponseModel) {
        let latitude = place.lat
        let longitude = place.lon
        let address = "\(place.regionName) + \(place.zip) +\(place.city)"
        let houseLocation = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )

        let annotation = MKPointAnnotation()
        annotation.coordinate = houseLocation
        annotation.title = address

        mapView.addAnnotation(annotation)
    }
    
    func showDetails(of place: ResponseModel) {
        let labelText = """

Name of country: \(place.country) \n
Country code: \(place.countryCode) \n
Region name: \(place.regionName) \n
Post code: \(place.zip) \n
City: \(place.city) \n
Latitude: \(place.lat) \n
Longitude: \(place.lon) \n
Time zone: \(place.timezone) \n
Telecommunication provider: \(place.org) \n

"""

        detailsLabel.text = labelText
    }
    func setupLayout() {
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(detailsLabel) {
            $0.top.equalTo(mapView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
