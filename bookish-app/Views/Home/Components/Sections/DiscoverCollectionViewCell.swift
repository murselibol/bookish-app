//
//  DiscoverCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 10.01.2024.
//

import UIKit

final class DiscoverCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DiscoverCollectionViewCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickItem)))
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var thumbnailImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dummy-thumbnail"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1(.medium)
        label.text = "Sineklerin Tanrısı"
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .Text2()
        label.text = "John Doe"
        label.textColor = .getColor(.text)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Text2()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
        label.textColor = .getColor(.textGray)
        label.numberOfLines = 4
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
        addSubview(thumbnailImage)
        addSubview(bookTitleLabel)
        addSubview(authorLabel)
        addSubview(descriptionLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        thumbnailImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(containerView.snp.height)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(0)
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(15)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(15)
        }
    }
    
    func setup(data: DiscoverSectionModel) {
        bookTitleLabel.text = data.title
        authorLabel.text = data.author
        descriptionLabel.text = data.description
    }
    
    @objc func onClickItem() {
        print("click item")
    }
}

