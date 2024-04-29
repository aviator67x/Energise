//
//  ButtonModel.swift
//  Energise
//
//  Created by Andrew Kasilov on 28.04.2024.
//

import Foundation

protocol ButtonModelProtocol: AnyObject {
    func passTime(time: String)
}

enum ButtonModelResponse {
    
}

final class ButtonModel {
    // - MARK: internal
    weak var delegate: ButtonModelProtocol?
    
    // - MARK: private
    private var timer: Timer?
    private var runCount = 0
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
        runCount += 1
        delegate?.passTime(time: String(runCount))

        if runCount == 10 {
            timer?.invalidate()
        }
    }
}
