//
//  SearchTextField.swift
//  bookish-app
//
//  Created by Mursel Elibol on 19.01.2024.
//

import UIKit

final class SearchTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 15, left: 45, bottom: 15, right: 15)
    private let placeholderColor = UIColor.init(hex: "#797878")
    
    private lazy var searchImageContainerView: UIView = UIView()
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = placeholderColor
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintUI()
        configureTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configureTextField() {
        addTarget(self, action: #selector(searchTextFieldDidBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(searchTextFieldDidEndEditing), for: .editingDidEnd)
        
        self.font = .Text1()
        self.textColor = .white
        self.attributedPlaceholder = NSAttributedString(string: "Enter...", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        self.layer.cornerRadius = UIScreen.main.bounds.width * 0.068
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.init(hex: "#242424")
        self.leftView = searchImageContainerView
        self.leftViewMode = .always
    }
    
    // MARK: - Constraint
    private func constraintUI() {
        searchImageContainerView.addSubview(searchImageView)
        
        searchImageView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
    }
    
    // MARK: - Override Functions
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // MARK: - Action Functions
    @objc private func searchTextFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.white.cgColor
        searchImageView.tintColor = .white
    }
    
    @objc private func searchTextFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.black.cgColor
        searchImageView.tintColor = placeholderColor
    }
}
