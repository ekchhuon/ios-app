//
//  SettingsViewController.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit
import Combine

class SettingsViewController: BaseViewController {
    private let viewModel: SettingsViewModel
    weak var coordinator: SettingsCoordinator?
    private var cancellables = Set<AnyCancellable>()
    var onDismiss: (() -> Void)?
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        title = "Settings"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupBindings() {
        viewModel.$settings
            .sink { [weak self] _ in
                self?.tableView.reloadData()
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

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let setting = viewModel.settings[indexPath.row]
        
        cell.textLabel?.text = setting.title
        
        switch setting.type {
        case .toggle:
            let switchView = UISwitch()
            switchView.isOn = setting.isEnabled
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            cell.selectionStyle = .none
        case .navigation:
            cell.accessoryType = .disclosureIndicator
        case .action:
            cell.textLabel?.textColor = .appError
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setting = viewModel.settings[indexPath.row]
        
        switch setting.type {
        case .action:
            if setting.title == "Logout" {
                viewModel.logout()
            }
        case .navigation:
            // Handle navigation
            break
        default:
            break
        }
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        // Handle toggle change
    }
}

