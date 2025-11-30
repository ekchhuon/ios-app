//
//  CustomButton.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit
import Combine

enum ButtonStyle {
    case primary
    case secondary
    case outline
    case text
}

class CustomButton: UIButton {
    private var style: ButtonStyle = .primary
    private let tapSubject = PassthroughSubject<Void, Never>()
    
    /// Combine publisher for button taps
    var tapPublisher: AnyPublisher<Void, Never> {
        tapSubject.eraseToAnyPublisher()
    }
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingState()
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    init(style: ButtonStyle = .primary, title: String = "") {
        super.init(frame: .zero)
        self.style = style
        setupButton()
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        layer.cornerRadius = AppTheme.Layout.smallCornerRadius
        titleLabel?.font = AppTheme.Typography.bodyBold
        snp.makeConstraints { make in
            make.height.equalTo(AppTheme.Layout.buttonHeight)
        }
        
        switch style {
        case .primary:
            backgroundColor = AppTheme.Colors.primary
            setTitleColor(.white, for: .normal)
        case .secondary:
            backgroundColor = AppTheme.Colors.secondary
            setTitleColor(.white, for: .normal)
        case .outline:
            backgroundColor = .clear
            setTitleColor(AppTheme.Colors.primary, for: .normal)
            layer.borderWidth = AppTheme.Layout.borderWidth
            layer.borderColor = AppTheme.Colors.primary.cgColor
        case .text:
            backgroundColor = .clear
            setTitleColor(AppTheme.Colors.primary, for: .normal)
        }
        
        // Add activity indicator
        addSubview(activityIndicator)
        activityIndicator.color = style == .primary || style == .secondary ? .white : AppTheme.Colors.primary
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.isHidden = true
        
        // Add tap action
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        tapSubject.send()
    }
    
    private func updateLoadingState() {
        if isLoading {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            isEnabled = false
            titleLabel?.alpha = 0
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            isEnabled = true
            titleLabel?.alpha = 1
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.6
        }
    }
}

