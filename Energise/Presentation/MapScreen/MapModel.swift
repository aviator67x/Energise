//
//  MapModel.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import Alamofire
import Foundation

protocol MapModelProtocol: AnyObject {
    func show(place: ResponseModel)
}

final class MapModel {
    weak var delegate: MapModelProtocol?

    // - MARK: private
    private var places: ResponseModel?
    private var dataToCache: CachedData?
    private let cache = NSCache<NSString, CachedData>()

    func getPlaces() {
        let urlStr = "http://ip-api.com/json"
        AF.request(urlStr).responseDecodable(of: ResponseModel.self) { [weak self] response in
            debugPrint(response)
            guard let strongSelf = self else {
                return
            }
            switch response.result {
            case .success(let place):
                strongSelf.cache(data: place)
                strongSelf.delegate?.show(place: place)
            case .failure:
                guard let place = self?.retrieveCachedData() else {
                    return
                }
                self?.delegate?.show(place: place)
                return
            }
        }
    }

    func cache(data: ResponseModel) {
        let myObject = CachedData(data: data)
        cache.setObject(myObject, forKey: "CachedObject")
    }

    func retrieveCachedData() -> ResponseModel? {
        guard let cachedVersion = cache.object(forKey: "CachedObject") else {
            return nil
        }
        return ResponseModel(data: cachedVersion.data)
    }
}
