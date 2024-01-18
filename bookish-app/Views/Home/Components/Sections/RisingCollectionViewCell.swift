//
//  RisingCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 9.01.2024.
//

import UIKit

final class RisingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RisingCollectionViewCell"
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
    
    private lazy var rankImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pennant"))
        return imageView
    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1(.medium)
        label.text = "01"
        label.textColor = .white
        return label
    }()
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1(.medium)
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
        containerView.addSubview(rankImageView)
        containerView.addSubview(rankLabel)
        containerView.addSubview(bookTitleLabel)
        containerView.addSubview(authorLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalToSuperview()
        }
        
        rankImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
            make.width.equalTo(25)
            make.height.equalTo(34)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.centerX.equalTo(rankImageView)
            make.centerY.equalTo(rankImageView).offset(-2)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(rankImageView.snp.bottom).offset(15)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview()
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(15)
        }
    }
    
    // MARK: - Functions
    func setup(data: RisingSectionModel) {
        bookId = data.id
        thumbnailImageView.loadURL(url: data.thumbnailUrl)
        updateRankImageColor(rank: data.rank)
        rankLabel.text = data.rank
        bookTitleLabel.text = data.title
        authorLabel.text = data.author
    }
    
    @objc private func onClickBook() {
        bookDelegate?.onClickBook(id: bookId)
    }
    
    private func updateRankImageColor(rank: String?){
        guard let rankValue = rank, let rankIndex = Int(rankValue) else { return }
        rankImageView.tintColor = UIColor(hex: CATEGORY_SECTION_COLORS[rankIndex-1])
    }
}

