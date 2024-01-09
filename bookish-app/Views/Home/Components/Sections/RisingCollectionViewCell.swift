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
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1()
        label.text = "1"
        label.textColor = .getColor(.text)
        return label
    }()
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1()
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
        
        rankLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(0)
            make.leading.equalTo(thumbnailImage.snp.trailing).offset(15)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(rankLabel.snp.bottom).offset(15)
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

