//
//  BookCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 9.01.2024.
//

import UIKit
import SnapKit

protocol BookCollectionCellViewDelegate: AnyObject {
    func constraintUI()
    func setUIData(data: BookSectionArguments)
}

final class BookCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookCollectionViewCell"
    var viewModel: BookCollectionViewCellVM?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
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
}

extension BookCollectionViewCell: BookCollectionCellViewDelegate {
    func constraintUI() {
        addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(bookTitleLabel)
        containerView.addSubview(bookDescriptionLabel)
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 3)
            make.height.equalTo(thumbnailImageView.snp.width).multipliedBy(1.5)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(12)
        }
        
        bookDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    func setUIData(data: BookSectionArguments) {
        thumbnailImageView.loadURL(url: data.thumbnailUrl)
        bookTitleLabel.text = data.title
        bookDescriptionLabel.text = data.description
    }
}
