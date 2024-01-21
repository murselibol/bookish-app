//
//  DiscoverCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 10.01.2024.
//

import UIKit

final class DiscoverCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DiscoverCollectionViewCell"
    weak var bookClickListener: BookClickListener?
    weak var authorClickListener: AuthorClickListener?
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
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickAuthor)))
        label.isUserInteractionEnabled = true
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
        thumbnailImageView.loadURL(url: data.thumbnailUrl)
        bookTitleLabel.text = data.title
        authorLabel.text = data.author
        descriptionLabel.text = data.description
    }
    
    @objc private func onClickBook() {
        bookClickListener?.onClickBook(id: bookId)
    }
    
    @objc private func onClickAuthor() {
        authorClickListener?.onClickAuthor(authorName: authorLabel.text ?? "")
    }
}

