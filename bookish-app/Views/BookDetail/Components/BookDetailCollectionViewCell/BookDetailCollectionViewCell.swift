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
    private lazy var viewModel = BookDetailCollectionViewCellVM(view: self)
    
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
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var readMoreContainerView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickReadMore)))
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var readMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "More"
        label.font = .Text2()
        label.textColor = .getColor(.textGray)
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        imageView.tintColor = .getColor(.textGray)
        return imageView
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
        addSubview(thumbnailImageView)
        addSubview(bookTitleLabel)
        addSubview(bookDescriptionLabel)
        addSubview(readMoreContainerView)
        addSubview(readMoreLabel)
        addSubview(chevronImageView)
        
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
        
        readMoreContainerView.snp.makeConstraints { make in
            make.top.equalTo(bookDescriptionLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(25)
        }
        
        readMoreLabel.snp.makeConstraints { make in
            make.top.equalTo(readMoreContainerView).offset(5)
            make.leading.equalTo(readMoreContainerView)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.top.equalTo(readMoreContainerView).offset(5)
            make.leading.equalTo(readMoreLabel.snp.trailing).offset(3)
            make.width.equalTo(12)
            make.height.equalTo(17)
        }

    }
    
    // MARK: - Functions
    func setup(data: BookResponse) {
        let bookInfo = data.volumeInfo
        thumbnailImageView.loadURL(url: data.volumeInfo?.imageLinks?.thumbnail ?? K.notFoundBookImage)
        bookTitleLabel.text = bookInfo?.title
        bookDescriptionLabel.text = bookInfo?.description
    }
    
    @objc private func onClickReadMore() {
        UIView.animate(withDuration: 0.3) {
            self.viewModel.isOpenReadMore.toggle()
            self.bookDescriptionLabel.numberOfLines = self.viewModel.isOpenReadMore ? 0 : 4
            self.readMoreLabel.text = self.viewModel.isOpenReadMore ? "Less" : "More"
            self.chevronImageView.image = UIImage(systemName: self.viewModel.isOpenReadMore ? "chevron.up" : "chevron.down")
            self.layoutIfNeeded()
        }
    }
}


extension BookDetailCollectionViewCell: BookDetailCollectionCellDelegate {
    
}
