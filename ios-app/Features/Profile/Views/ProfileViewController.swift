//
//  ProfileViewController.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit
import Combine

class ProfileViewController: BaseViewController {
    private let viewModel: ProfileViewModel
    weak var coordinator: ProfileCoordinator?
    private var cancellables = Set<AnyCancellable>()
    var onDismiss: (() -> Void)?
    
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        title = "Profile"
        
        nameLabel.font = .appHeading2()
        view.addSubview(nameLabel)
        
        emailLabel.font = .appBody()
        emailLabel.textColor = .appSecondaryText
        view.addSubview(emailLabel)
    }
    
    override func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(AppSpacing.xl)
            make.leading.trailing.equalToSuperview().inset(AppSpacing.lg)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(AppSpacing.md)
            make.leading.trailing.equalToSuperview().inset(AppSpacing.lg)
        }
    }
    
    override func setupBindings() {
        viewModel.$userName
            .sink { [weak self] text in
                self?.nameLabel.text = text
            }
            .store(in: &cancellables)
        
        viewModel.$userEmail
            .sink { [weak self] text in
                self?.emailLabel.text = text
            }
            .store(in: &cancellables)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Check if view controller is being popped (not just covered)
        if isMovingFromParent {
            onDismiss?()
        }
    }
}

