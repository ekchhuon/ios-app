//
//  LoadingView.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppTheme.Colors.surface
        view.layer.cornerRadius = AppTheme.Layout.cornerRadius
        AppTheme.Shadow.apply(to: view.layer, style: .medium)
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = AppTheme.Colors.primary
        return indicator
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = AppTheme.Typography.callout
        label.textColor = AppTheme.Colors.textSecondary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    var message: String? {
        didSet {
            messageLabel.text = message
            messageLabel.isHidden = message == nil
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        isHidden = true
        
        addSubview(containerView)
        containerView.addSubview(activityIndicator)
        containerView.addSubview(messageLabel)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.greaterThanOrEqualTo(120)
            make.height.greaterThanOrEqualTo(120)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(AppTheme.Spacing.large)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(activityIndicator.snp.bottom).offset(AppTheme.Spacing.medium)
            make.leading.trailing.equalToSuperview().inset(AppTheme.Spacing.medium)
            make.bottom.equalToSuperview().offset(-AppTheme.Spacing.large)
        }
        
        messageLabel.isHidden = true
    }
    
    // MARK: - Public Methods
    func show(in view: UIView? = nil, message: String? = nil) {
        self.message = message
        
        // Get target view - use provided view or find the key window
        let targetView: UIView?
        if let providedView = view {
            targetView = providedView
        } else {
            // Get key window - works for iOS 13+
            targetView = getKeyWindow()
        }
        
        guard let targetView = targetView else {
            Logger.shared.warning("LoadingView: Could not find target view to show loading")
            return
        }
        
        if superview == nil {
            targetView.addSubview(self)
            self.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        isHidden = false
        alpha = 0
        activityIndicator.startAnimating()
        
        AppTheme.Animation.animate(duration: AppTheme.Animation.shortDuration) {
            self.alpha = 1
        }
    }
    
    // MARK: - Helper Methods
    private func getKeyWindow() -> UIWindow? {
        // Get all window scenes
        let windowScenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        
        // Find the key window across all scenes
        for scene in windowScenes {
            // For iOS 15+, windows property is deprecated but still works
            // We iterate through all windows to find the key one
            if #available(iOS 15.0, *) {
                // iOS 15+ - Check all windows in the scene
                for window in scene.windows {
                    if window.isKeyWindow {
                        return window
                    }
                }
            } else {
                // iOS 13-14 - Use windows property directly
                if let keyWindow = scene.windows.first(where: { $0.isKeyWindow }) {
                    return keyWindow
                }
            }
        }
        
        return nil
    }
    
    func hide() {
        AppTheme.Animation.animate(
            duration: AppTheme.Animation.shortDuration,
            animations: {
                self.alpha = 0
            },
            completion: { _ in
                self.isHidden = true
                self.activityIndicator.stopAnimating()
                self.removeFromSuperview()
            }
        )
    }
}

