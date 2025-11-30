//
//  HomeViewController.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit
import Combine

class HomeViewController: BaseViewController {
    private let viewModel: HomeViewModel
    weak var coordinator: HomeCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLabel = UILabel()
    private let profileButton = UIButton(type: .system)
    private let settingsButton = UIButton(type: .system)
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        title = "Home"
        
        // Title Label
        titleLabel.font = .appHeading1()
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        // Profile Button
        profileButton.setTitle("Profile", for: .normal)
        profileButton.backgroundColor = .appPrimary
        profileButton.setTitleColor(.white, for: .normal)
        profileButton.layer.cornerRadius = 8
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        view.addSubview(profileButton)
        
        // Settings Button
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.backgroundColor = .appSecondary
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.layer.cornerRadius = 8
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        view.addSubview(settingsButton)
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(AppSpacing.xl)
            make.leading.trailing.equalToSuperview().inset(AppSpacing.lg)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(AppSpacing.xl)
            make.leading.trailing.equalToSuperview().inset(AppSpacing.lg)
            make.height.equalTo(50)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(AppSpacing.md)
            make.leading.trailing.equalToSuperview().inset(AppSpacing.lg)
            make.height.equalTo(50)
        }
    }
    
    override func setupBindings() {
        viewModel.$welcomeMessage
            .sink { [weak self] text in
                self?.titleLabel.text = text
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.showLoading()
                } else {
                    self?.hideLoading()
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func profileButtonTapped() {
        // Option 1: Using Coordinator (Recommended for production)
        coordinator?.showProfile()
        
        // Option 2: Direct navigation (Quick but not recommended)
        // let viewModel = ProfileViewModel()
        // self.navigationController?.pushViewController(ProfileViewController(viewModel: viewModel), animated: true)
    }
    
    @objc private func settingsButtonTapped() {
        coordinator?.showSettings()
    }
}

