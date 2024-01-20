//
//  SearchTextFieldView.swift
//  bookish-app
//
//  Created by Mursel Elibol on 19.01.2024.
//

import UIKit

protocol SearchCollectionReuseViewDelegate: AnyObject {
    func onChangeSearchTextField(text: String)
}

final class SearchCollectionReuseView: UICollectionReusableView {
    
    static let identifier = "SearchCollectionReuseView"
    weak var delegate: SearchCollectionReuseViewDelegate?
    
    private lazy var searchTextField: SearchTextField = {
        let tf = SearchTextField()
        tf.placeholder = "book name, author, isbn..."
        return tf
    }()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchTextField.delegate = self
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraint
    private func constraintUI() {
        addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
        }
    }
}

extension SearchCollectionReuseView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.onChangeSearchTextField(text: searchTextField.text ?? "")
    }
}
