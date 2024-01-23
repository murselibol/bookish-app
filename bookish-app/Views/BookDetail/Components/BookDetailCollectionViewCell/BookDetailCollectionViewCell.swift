//
//  BookDetailCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 14.01.2024.
//

import UIKit

protocol BookDetailDelegate: AnyObject {
    func onClickAuthor(authorName: String)
}

protocol BookDetailCollectionCellDelegate: AnyObject {
}

final class BookDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookDetailCollectionViewCell"
    weak var bookDetailDelegate: BookDetailDelegate?
    private lazy var viewModel = BookDetailCollectionViewCellVM(view: self)
    private var book: BookResponse!
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dummy-thumbnail"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title2(.semibold)
        label.textColor = .getColor(.bookTitle)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .Title3()
        label.textColor = .getColor(.primary)
        label.numberOfLines = 1
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickAuthor)))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        stackView.spacing = 18
        return stackView
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Text2()
        label.textColor = .getColor(.text)
        label.text = "27 Rating"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1(.semibold)
        label.textColor = .getColor(.text)
        label.text = "4,7"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Text2()
        label.textColor = .getColor(.text)
        label.text = "Category"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1(.semibold)
        label.textColor = .getColor(.text)
        label.text = "Love"
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Text2()
        label.textColor = .getColor(.text)
        label.text = "Page"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.font = .Text1(.semibold)
        label.textColor = .getColor(.text)
        label.text = "127"
        label.textAlignment = .center
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
        label.text = "Read more"
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
        addSubview(authorLabel)
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(ratingStackView)
        infoStackView.addArrangedSubview(categoryStackView)
        infoStackView.addArrangedSubview(pageStackView)
        ratingStackView.addArrangedSubview(ratingTitleLabel)
        ratingStackView.addArrangedSubview(ratingLabel)
        categoryStackView.addArrangedSubview(categoryTitleLabel)
        categoryStackView.addArrangedSubview(categoryLabel)
        pageStackView.addArrangedSubview(pageTitleLabel)
        pageStackView.addArrangedSubview(pageLabel)
        infoStackView.addVerticalSeparators(color: .getColor(.textGray), width: 1)
        addSubview(bookDescriptionLabel)
        addSubview(readMoreContainerView)
        readMoreContainerView.addSubview(readMoreLabel)
        readMoreContainerView.addSubview(chevronImageView)
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(thumbnailImageView.snp.width).multipliedBy(1.65)
        }

        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview()
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(320)
            make.height.lessThanOrEqualTo(400)
        }
        
        pageStackView.snp.makeConstraints { make in
            make.width.equalTo(ratingStackView)
            make.width.greaterThanOrEqualTo(70)
        }
        
        pageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(pageTitleLabel)
        }
        
        bookDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
        }
        
        readMoreContainerView.snp.makeConstraints { make in
            make.top.equalTo(bookDescriptionLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.width.equalTo(90)
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
        self.book = data
        let bookInfo = data.volumeInfo
        thumbnailImageView.loadURL(url: data.volumeInfo?.imageLinks?.thumbnail)
        bookTitleLabel.text = bookInfo?.title
        authorLabel.text = bookInfo?.authors?.first ?? "-"
        ratingTitleLabel.text = String(bookInfo?.ratingsCount ?? 0) + " Ratings"
        ratingLabel.text = String(bookInfo?.averageRating ?? 0)
        categoryLabel.text = String(bookInfo?.categories?.first ?? "-")
        pageLabel.text = String(bookInfo?.pageCount ?? 0)
        bookDescriptionLabel.text = bookInfo?.description?.htmlToString()
    }
    
    @objc private func onClickAuthor() {
        bookDetailDelegate?.onClickAuthor(authorName: book.volumeInfo?.authors?.first ?? "")
    }
    
    @objc private func onClickReadMore() {
        UIView.animate(withDuration: 0.3) {
            self.viewModel.isOpenReadMore.toggle()
            self.bookDescriptionLabel.numberOfLines = self.viewModel.isOpenReadMore ? 0 : 4
            self.readMoreLabel.text = self.viewModel.isOpenReadMore ? "Less more" : "Read more"
            self.chevronImageView.image = UIImage(systemName: self.viewModel.isOpenReadMore ? "chevron.up" : "chevron.down")
            self.layoutIfNeeded()
        }
    }
}


extension BookDetailCollectionViewCell: BookDetailCollectionCellDelegate {
    
}

