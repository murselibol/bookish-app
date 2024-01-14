//
//  BookDetailCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 14.01.2024.
//

import UIKit

protocol BookDetailCollectionCellDelegate: AnyObject {
}

final class BookDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookDetailCollectionViewCell"
    private lazy var bookId: String = ""
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dummy-thumbnail"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title1(.semibold)
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bookDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Text2()
        label.textColor = .getColor(.textGray)
        label.numberOfLines = 5
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraintUI() {
        addSubview(thumbnailImageView)
        addSubview(bookTitleLabel)
        addSubview(bookDescriptionLabel)
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(thumbnailImageView.snp.width).multipliedBy(1.65)
        }

        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        bookDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setup(data: BookResponse) {
        let bookInfo = data.volumeInfo
        thumbnailImageView.loadURL(url: data.volumeInfo?.imageLinks?.thumbnail ?? K.notFoundBookImage)
        bookTitleLabel.text = bookInfo?.title
        bookDescriptionLabel.text = bookInfo?.description
    }
}
