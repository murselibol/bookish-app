//
//  CategoryCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import UIKit

protocol CategoryCollectionViewCellDelegate: AnyObject {
    func onSelectCategory(category: String)
}

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    weak var delegate: CategoryCollectionViewCellDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = .blue
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickCategory)))
        view.isUserInteractionEnabled = true
        return view
    }()

    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraintUI() {
        addSubview(containerView)
        addSubview(categoryName)

        containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }

        categoryName.snp.makeConstraints { make in
            make.edges.equalTo(containerView).inset(UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30))
        }
    }
    
    func setup(categoryName: String) {
        self.categoryName.text = categoryName
    }
    
    @objc func onClickCategory() {
        delegate?.onSelectCategory(category: categoryName.text ?? "")
    }
}
