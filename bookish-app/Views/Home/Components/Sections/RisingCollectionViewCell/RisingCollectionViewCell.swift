//
//  RisingCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 9.01.2024.
//

import UIKit

protocol RisingCollectionCellViewDelegate: AnyObject {
    func constraintUI()
    func setUIData(data: RisingSectionArguments)
}

final class RisingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RisingCollectionViewCell"
    var viewModel: RisingCollectionViewCellVM?
    
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
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickAuthor)))
        label.isUserInteractionEnabled = true
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

// MARK: - RisingCollectionCellViewDelegate
extension RisingCollectionViewCell: RisingCollectionCellViewDelegate {
    func constraintUI() {
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
    
    func setUIData(data: RisingSectionArguments) {
        DispatchQueue.main.async {
            self.thumbnailImageView.loadURL(url: data.thumbnailUrl)
            self.rankImageView.tintColor = UIColor.init(hex: (self.viewModel?.getRankImageColorByRank(rank: data.rank))!)
            self.rankLabel.text = self.viewModel?.getRankLabelByRank(rank: data.rank)
            self.bookTitleLabel.text = data.title
            self.authorLabel.text = data.author
        }
    }
}
