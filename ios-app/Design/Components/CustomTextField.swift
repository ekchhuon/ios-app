//
//  CustomTextField.swift
//  ios-app
//
//  Created by ekchhuon on 21/11/25.
//

import UIKit
import SnapKit
import Combine

class CustomTextField: UITextField {
    var errorMessage: String? {
        didSet {
            updateErrorState()
        }
    }
    
    private let errorLabel = UILabel()
    private let textSubject = PassthroughSubject<String, Never>()
    
    /// Combine publisher for text changes
    var textPublisher: AnyPublisher<String, Never> {
        textSubject.eraseToAnyPublisher()
    }
    
    init(placeholder: String = "", isSecure: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        borderStyle = .roundedRect
        font = AppTheme.Typography.body
        layer.cornerRadius = AppTheme.Layout.smallCornerRadius
        layer.borderWidth = AppTheme.Layout.borderWidth
        layer.borderColor = AppTheme.Colors.border.cgColor
        
        // Error label
        errorLabel.font = AppTheme.Typography.caption1
        errorLabel.textColor = AppTheme.Colors.error
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        
        // Observe text changes
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func textDidChange() {
        textSubject.send(text ?? "")
    }
    
    private func updateErrorState() {
        if let error = errorMessage, !error.isEmpty {
            layer.borderColor = AppTheme.Colors.error.cgColor
            errorLabel.text = error
            errorLabel.isHidden = false
        } else {
            layer.borderColor = AppTheme.Colors.border.cgColor
            errorLabel.isHidden = true
        }
    }
    
    /// Add error label to parent view
    func addErrorLabel(to parentView: UIView, below textField: UIView) {
        parentView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(AppTheme.Spacing.extraSmall)
            make.leading.trailing.equalTo(textField)
        }
    }
}

