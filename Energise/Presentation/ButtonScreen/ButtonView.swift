//
//  ButtonView.swift
//  Energise
//
//  Created by Andrew Kasilov on 29.04.2024.
//

import SnapKit
import UIKit

protocol ButtonViewProtocol: AnyObject {
    func onButtonTap(action: ButtonViewAction)
}

enum ButtonViewAction {
    case play
    case pause
}

final class ButtonView: UIView {
    private enum ButtonState {
        case play
        case pause
    }
    
    // - MARK: views
    private lazy var button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 30)
        configuration.attributedTitle = AttributedString("Play", attributes: container)
        configuration.image = UIImage(systemName: "play.fill")
        configuration.imagePlacement = .top
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 60)
        configuration.titlePadding = 10
        configuration.imagePadding = 10
        configuration.background.cornerRadius = 100
        configuration.baseBackgroundColor = .blue
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var timerLabel: InsetLabel = {
        let label = InsetLabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.backgroundColor = .blue
        label.textColor = .white
        label.text = "00:00:00"
        label.textAlignment = .center
        return label
    }()
    
    // - MARK: private
    private var buttonState: ButtonState = .pause
    
    // - MARK: internal
    weak var delegate: ButtonViewProtocol?
    
    // - MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func play() {
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 30)
        button.configuration?.attributedTitle = AttributedString("Pause", attributes: container)
        button.configuration?.image = UIImage(systemName: "pause.fill")
        
        timerLabel.layer.removeAllAnimations()
        beginAnimation(childView: button)
    }
    
    func pause() {
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 30)
        button.configuration?.attributedTitle = AttributedString("Play", attributes: container)
        button.configuration?.image = UIImage(systemName: "play.fill")
        
        button.layer.removeAllAnimations()
        beginAnimation(childView: timerLabel)
    }
    
    func updateTimerLabel(_ time: String) {
        timerLabel.text = time
    }
}

// - MARK: @objc
private extension ButtonView {
    @objc func buttonAction() {
        switch buttonState {
        case .pause:
            buttonState = .play
            delegate?.onButtonTap(action: .play)
        case .play:
            buttonState = .pause
            delegate?.onButtonTap(action: .pause)
        }
    }
}

private extension ButtonView {
    func setupLayout() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 200).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timerLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -50).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func beginAnimation(childView: UIView) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            childView.transform = CGAffineTransformMakeScale(1.2, 1.2)
        }, completion: { _ in
            childView.transform = CGAffineTransformMakeScale(1, 1)
        })
        let opacityAnimation = opacityAnimation()
        childView.layer.add(opacityAnimation, forKey: "animateOpacity")
    }
    
    func opacityAnimation() -> CABasicAnimation {
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0.5
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        return pulseAnimation
    }
}
