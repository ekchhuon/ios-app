//
//  BaseViewController.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupBindings()
    }
    
    // MARK: - Setup Methods (Override in subclasses)
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        // Override in subclasses
    }
    
    func setupBindings() {
        // Override in subclasses
    }
    
    // MARK: - Loading Indicator
    private var loadingView: UIView?
    
    func showLoading() {
        guard loadingView == nil else { return }
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.addSubview(containerView)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        containerView.addSubview(activityIndicator)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        loadingView = containerView
    }
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    // MARK: - Error Alert
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

