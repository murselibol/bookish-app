//
//  BookListCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 14.01.2024.
//

import UIKit
import SnapKit

protocol BookListCollectionCellViewDelegate: AnyObject {
    func constraintUI()
    func setUIData(data: BookListCellArguments)
}

final class BookListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookListCollectionViewCell"
    var viewModel: BookListCollectionViewCellVM?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBook)))
        view.addLongPressOpacity()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image-not-found"))
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
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickAuthor)))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Description()
        label.text = "Lorem ipsum"
        label.textColor = .getColor(.textGray)
        label.numberOfLines = 4
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
    @objc private func onClickBook() {
        viewModel?.onClickBook()
    }
    
    @objc private func onClickAuthor() {
        viewModel?.onClickAuthor()
    }
}

// MARK: - BookListCollectionCellViewDelegate
extension BookListCollectionViewCell: BookListCollectionCellViewDelegate {
    func constraintUI() {
        addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(bookTitleLabel)
        containerView.addSubview(authorLabel)
        containerView.addSubview(descriptionLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalToSuperview()
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(6)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(12)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
        }
    }
    
    func setUIData(data: BookListCellArguments) {
        thumbnailImageView.loadURL(url: data.thumbnailUrl)
        bookTitleLabel.text = data.title
        authorLabel.text = data.author
        descriptionLabel.text = data.description
    }
}
