//
//  ViewController.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Set background color
        view.backgroundColor = .systemBackground
        
        // Example: Add a label programmatically
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to iOS App"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

}

