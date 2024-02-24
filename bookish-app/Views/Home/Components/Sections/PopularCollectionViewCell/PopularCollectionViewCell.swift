//
//  PopularsCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 7.01.2024.
//

import UIKit
import SnapKit

protocol PopularCollectionCellViewDelegate: AnyObject {
    func constraintUI()
    func setUIData(data: PopularSectionArguments)
}

final class PopularCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCollectionViewCell"
    var viewModel: PopularCollectionViewCellVM?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBook)))
        view.addLongPressOpacity()
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
        label.text = "Sineklerin Tanrısı"
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 2
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

// MARK: - PopularCollectionCellView
extension PopularCollectionViewCell: PopularCollectionCellViewDelegate {
    func constraintUI() {
        addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(bookTitleLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().offset(-50)
        }
        
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setUIData(data: PopularSectionArguments) {
        thumbnailImageView.loadURL(url: data.thumbnailUrl)
        bookTitleLabel.text = data.title
    }
}
