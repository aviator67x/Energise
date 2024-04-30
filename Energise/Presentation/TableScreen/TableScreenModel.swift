//
//  TableScreenModel.swift
//  Energise
//
//  Created by Andrew Kasilov on 30.04.2024.
//

import Foundation
import StoreKit
import UIKit

final class TableScreenModel {
    func rate() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    func contact() {
        if let url = URL(string: "https://energise.notion.site/Swift-fac45cd4d51640928ce8e7ea38552fc3"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
