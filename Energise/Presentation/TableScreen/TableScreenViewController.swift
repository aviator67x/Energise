//
//  TableViewController.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import UIKit

class TableScreenViewController: UIViewController {
    // - MARK: private
    private let tableScreenView = TableScreenView()
    private let tableScreenModel = TableScreenModel()

    // - MARK: lifecycle
    override func loadView() {
        super.loadView()
        view = tableScreenView
        tableScreenView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// - MARK: TableScreenViewProtocol
extension TableScreenViewController: TableScreenViewProtocol {
    func subviews(action: TableScreenViewAction) {
        switch action {
        case .rate:
            tableScreenModel.rate()
        case .share:
            share()
        case .contact:
            tableScreenModel.contact()
        }
    }
}

// - MARK: private extension
private extension TableScreenViewController {
    func share() {
        let comment = "Bored Ape"

        guard let image = UIImage(named: "monkey") else {
            return
        }
        let activityViewController = UIActivityViewController(
            activityItems: [comment, image], applicationActivities: nil)

        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]

        activityViewController.isModalInPresentation = true
        present(activityViewController, animated: true, completion: nil)
    }
}
