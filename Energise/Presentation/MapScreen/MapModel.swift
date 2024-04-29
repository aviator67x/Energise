//
//  MapModel.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import Alamofire
import Foundation

protocol MapModelProtocol: AnyObject {
    func show(places: [ResponseModel])
}

final class MapModel {
    weak var delegate: MapModelProtocol?

    // - MARK: private
    private var places: [ResponseModel] = []

    func getPlaces() {
        let urlStr = "http://ip-api.com/json/?fields=61439"
        AF.request(urlStr).responseDecodable(of: ResponseModel.self) { [weak self] response in
            debugPrint(response)
            guard let strongSelf = self,
                  let places = response.value
            else {
                return
            }
            strongSelf.places.append(places)
            strongSelf.delegate?.show(places: strongSelf.places)
        }
    }
}
