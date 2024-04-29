//
//  ButtonModel.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import Foundation

protocol ButtonModelProtocol: AnyObject {
    func passTime(time: String)
}

final class ButtonModel {
    // - MARK: internal
    weak var delegate: ButtonModelProtocol?

    // - MARK: private
    private var timer: Timer?
    private var seconds = 0

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        timer?.invalidate()
        seconds = 0
        let timeString = timeString(time: TimeInterval(seconds))
        delegate?.passTime(time: timeString)
    }
}

// - MARK: @objc
private extension ButtonModel {
    @objc func fireTimer() {
        seconds += 1
        let timeString = timeString(time: TimeInterval(seconds))
        delegate?.passTime(time: timeString)

        if seconds == 620 {
            timer?.invalidate()
        }
    }
}

// - MARK: private extension
private extension ButtonModel {
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
