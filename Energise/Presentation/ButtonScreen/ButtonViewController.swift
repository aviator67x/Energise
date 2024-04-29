//
//  ButtonViewController.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import UIKit

class ButtonViewController: UIViewController {
    // - MARK: private
    private let buttonView = ButtonView()
    private let buttonModel = ButtonModel()

    // - MARK: lifecycle
    override func loadView() {
        super.loadView()
        view = buttonView
        buttonView.delegate = self
        buttonModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// - MARK: ButtonViewProtocol
extension ButtonViewController: ButtonViewProtocol {
    func onButtonTap(action: ButtonViewAction) {
        switch action {
        case .play:
            buttonView.play()
            buttonModel.startTimer()
        case .pause:
            buttonView.pause()
            buttonModel.stopTimer()
        }
    }
}

// - MARK: ButtonModelProtocol
extension ButtonViewController: ButtonModelProtocol {
    func passTime(time: String) {
        buttonView.updateTimerLabel(time)
    }
}
