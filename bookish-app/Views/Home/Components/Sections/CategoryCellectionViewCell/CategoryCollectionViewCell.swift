//
//  CategoryCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import UIKit

protocol CategoryCollectionCellViewDelegate: AnyObject {
    func constraintUI()
    func setUIData(data: CategorySectionArguments)
}

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    var viewModel: CategoryCollectionViewCellVM?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickCategory)))
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var waveImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "wave"))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.3
        return imageView
    }()

    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewModel?.initCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    @objc private func onClickCategory() {
        viewModel?.onClickCategory()
    }
}

// MARK: - CategoryCollectionCellViewDelegate
extension CategoryCollectionViewCell: CategoryCollectionCellViewDelegate {
    func constraintUI() {
        addSubview(containerView)
        containerView.addSubview(waveImageView)
        containerView.addSubview(categoryName)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        waveImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalTo(200)
        }

        categoryName.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(70)
        }
    }
    
    func setUIData(data: CategorySectionArguments) {
        self.categoryName.text = data.name
        self.containerView.backgroundColor = UIColor(hex: data.color)
    }
}
