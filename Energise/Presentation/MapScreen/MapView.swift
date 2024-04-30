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
    func subviews(action: MapViewAction)
}

enum MapViewAction {
    case reloadData
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
        label.backgroundColor = .lightGray
        label.textColor = .white
        label.text = "00:00:00"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var reloadButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 30)
        configuration.attributedTitle = AttributedString(NSLocalizedString("reload", comment: ""), attributes: container)
        configuration.titlePadding = 10
        configuration.baseBackgroundColor = .orange
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        return refreshControl
    }()

    // - MARK: internal
    weak var delegate: MapViewProtocol?

    // - MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animate() {
        UIView.animate(withDuration: 1.0, animations: {
            self.mapView.frame.size.height += 200
        })
    }

    func show(place: ResponseModel) {
        showDetails(of: place)
        showOnMap(place: place)
    }
}

// - MARK: @objc
private extension MapView {
    @objc
    func buttonAction() {
        delegate?.subviews(action: .reloadData)
    }

    @objc
    func refreshControlAction() {
        delegate?.subviews(action: .reloadData)
    }
}

// - MARK: private extension
private extension MapView {
    func showOnMap(place: ResponseModel) {
        let latitude = place.lat
        let longitude = place.lon
        let address = "\(place.regionName)  \(place.zip) \(place.city)"
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

                \(NSLocalizedString("name_of_country", comment: "")): \(place.country) \n
                \(NSLocalizedString("country_code", comment: "")): \(place.countryCode) \n
                \(NSLocalizedString("region_name", comment: "")): \(place.regionName) \n
                \(NSLocalizedString("post_code", comment: "")): \(place.zip) \n
                \(NSLocalizedString("city", comment: "")): \(place.city) \n
                \(NSLocalizedString("latitude", comment: "")): \(place.lat) \n
                \(NSLocalizedString("longitude", comment: "")): \(place.lon) \n
                \(NSLocalizedString("time_zone", comment: "")): \(place.timezone) \n
                \(NSLocalizedString("tele_provider", comment: "")): \(place.org) \n

        """

        detailsLabel.text = labelText
    }

    func setupLayout() {
        addSubview(mapView) {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }

        addSubview(scrollView) {
            $0.top.equalTo(mapView.snp.bottom)
            $0.leading.trailing.width.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }

        scrollView.addSubview(reloadButton) {
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }

        scrollView.addSubview(detailsLabel) {
            $0.top.width.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
            $0.bottom.equalTo(reloadButton.snp.top).offset(-20)
        }

        scrollView.addSubview(refreshControl)
    }
}
