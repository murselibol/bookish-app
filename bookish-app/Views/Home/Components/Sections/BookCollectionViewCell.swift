//
//  BookCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 9.01.2024.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    weak var bookDelegate: BookDelegate?
    private lazy var id: String = ""
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
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
        label.font = .Text1(.semibold)
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
        addSubview(containerView)
        addSubview(thumbnailImageView)
        addSubview(bookTitleLabel)
        addSubview(bookDescriptionLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(containerView)
            make.width.equalTo(UIScreen.main.bounds.width/3)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(12)
        }
        
        bookDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(8)
        }
    }
    
    func setup(data: BookSectionModel) {
        thumbnailImageView.loadURL(url: data.thumbnailUrl ?? K.notFoundBookImage)
        bookTitleLabel.text = data.title
        bookDescriptionLabel.text = data.description
    }
    
    @objc func onClickBook() {
        bookDelegate?.onClickBook(id: id)
    }
}
