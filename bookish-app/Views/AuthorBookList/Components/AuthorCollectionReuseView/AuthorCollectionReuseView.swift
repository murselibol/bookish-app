//
//  AuthorCollectionReuseView.swift
//  bookish-app
//
//  Created by Mursel Elibol on 21.01.2024.
//

import UIKit

final class AuthorCollectionReuseView: UICollectionReusableView {
    
    static let identifier = "AuthorCollectionReuseView"
    
    private let profileImageSize = UIScreen.main.bounds.width / 3
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "author-profile")
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.getColor(.text).cgColor
        imageView.layer.cornerRadius = profileImageSize / 2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Title2(.semibold)
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.font = .Text2(.semibold)
        label.textColor = .getColor(.textGray)
        label.text = "Lorem ipsum dolor sit amet. Nam exercitationem consequatur qui porro accusantium non dolorem fuga vel voluptas dolorem. Quo assumenda consequatur in minus rerum cum enim possimus ut impedit aliquid ex praesentium."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .getColor(.text)
        return view
    }()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Constraint
    private func constraintUI() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(aboutLabel)
        addSubview(dividerView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(profileImageSize)
            make.height.equalTo(profileImageSize)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        aboutLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(aboutLabel.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
            make.width.equalTo(profileImageSize * 1.3)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Functions
    func setup(authorName: String) {
        nameLabel.text = authorName
    }
}

