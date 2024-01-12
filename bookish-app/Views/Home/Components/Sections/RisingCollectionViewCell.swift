//
//  RisingCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 9.01.2024.
//

import UIKit

final class RisingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RisingCollectionViewCell"
    
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
    
    private lazy var rankImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pennant"))
        return imageView
    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1(.medium)
        label.text = "01"
        label.textColor = .white
        return label
    }()
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1(.medium)
        label.text = "Sineklerin Tanrısı"
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 2
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintUI() {
        addSubview(containerView)
        addSubview(thumbnailImage)
        addSubview(rankImageView)
        addSubview(rankLabel)
        addSubview(bookTitleLabel)
        addSubview(authorLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        thumbnailImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(containerView.snp.height)
        }
        
        rankImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(15)
            make.width.equalTo(25)
            make.height.equalTo(34)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.centerX.equalTo(rankImageView)
            make.centerY.equalTo(rankImageView).offset(-3)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(rankImageView.snp.bottom).offset(15)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(15)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(15)
        }
    }
    
    @objc func onClickItem() {
        print("click item")
    }
}

