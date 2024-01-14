//
//  BookListCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 14.01.2024.
//

import UIKit

final class BookListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DiscoverCollectionViewCell"
    weak var bookDelegate: BookDelegate?
    private lazy var bookId: String = ""
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBook)))
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
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
        label.text = "Lorem ipsum"
        label.textColor = .getColor(.textGray)
        label.numberOfLines = 4
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
    
    // MARK: - Constaint
    private func constraintUI() {
        addSubview(containerView)
        addSubview(thumbnailImageView)
        addSubview(bookTitleLabel)
        addSubview(authorLabel)
        addSubview(descriptionLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(containerView.snp.height)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(0)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
        }
    }
    
    // MARK: - Functions
    func setup(data: DiscoverSectionModel) {
        bookId = data.id
        thumbnailImageView.loadURL(url: data.thumbnailUrl ?? K.notFoundBookImage)
        bookTitleLabel.text = data.title
        authorLabel.text = data.author
        descriptionLabel.text = data.description
    }
    
    @objc private func onClickBook() {
        bookDelegate?.onClickBook(id: bookId)
    }
}
