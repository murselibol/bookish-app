//
//  BookCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 9.01.2024.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    
    private lazy var thumbnailImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dummy-thumbnail"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title3(.semibold)
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var bookDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Text2()
        label.textColor = .getColor(.text)
        label.numberOfLines = 5
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
        addSubview(thumbnailImage)
        addSubview(bookTitleLabel)
        addSubview(bookDescriptionLabel)
        
        thumbnailImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width/3)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(thumbnailImage.snp.bottom).offset(12)
        }
        
        bookDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(8)
        }
    }
    
    func setup() {
        bookTitleLabel.text = "Dare to Love"
        bookDescriptionLabel.text = "She arouses his dominant and protective instincts And he will do anything to possess her … And does. When billionaire Ian Dare gets one glimpse of the sensual and irresistible Riley Taylor, he knows that he must have her. But any future he might have with Riley means he’ll have to confront his past—a past he’d rather forget. And that’s something this NFL team owner won’t dare to do—not even for love"
    }
}
