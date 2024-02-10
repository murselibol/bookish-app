//
//  BookDetailVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import UIKit
import SnapKit

protocol BookDetailVCDelegate: AnyObject {
    func constraintUI()
    func constraintIndicatorView()
    func updateIndicatorState(hidden: Bool)
    func setData(args: BookDetailArguments)
}

final class BookDetailVC: UIViewController {
    
    var viewModel: BookDetailVM!
    weak var coordinator: BookDetailCoordinator?
    
    private lazy var indicatorView = IndicatorView()
    
    private lazy var pageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var pageContentView: UIView = {
        let view = UIView()
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
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickAuthor)))
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
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickReadMore)))
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
    init(id: String) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = BookDetailVM(view: self, id: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .getColor(.background)
        viewModel.viewDidLoad()
    }
    
    deinit { coordinator?.finishCoordinator() }
    
    // MARK: - Functions
    @objc private func onClickAuthor() {
        coordinator?.navigateAuthorBookListVC(authorName: viewModel.authorName)
    }
    
    @objc private func onClickReadMore() {
        let data = self.viewModel.onClickReadMore()
        UIView.animate(withDuration: 0.3) {
            self.bookDescriptionLabel.numberOfLines = data.line
            self.readMoreLabel.text = data.text
            self.chevronImageView.image = UIImage(systemName: data.image)
            self.view.layoutIfNeeded()
        }
    }
    
}

// MARK: - BookDetailVCDelegate
extension BookDetailVC: BookDetailVCDelegate {
    func constraintUI() {
        view.addSubview(pageScrollView)
        pageScrollView.addSubview(pageContentView)
        pageContentView.addSubview(thumbnailImageView)
        pageContentView.addSubview(bookTitleLabel)
        pageContentView.addSubview(authorLabel)
        pageContentView.addSubview(infoStackView)
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
        pageContentView.addSubview(bookDescriptionLabel)
        pageContentView.addSubview(readMoreContainerView)
        readMoreContainerView.addSubview(readMoreLabel)
        readMoreContainerView.addSubview(chevronImageView)
        
        pageScrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        pageContentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-K.pageBottomSpace)
            make.leading.equalTo(view).offset(K.pageLeftSpace)
            make.trailing.equalTo(view).offset(-K.pageRightSpace)
        }
        
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
            make.bottom.equalToSuperview()
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
    
    func constraintIndicatorView() {
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        updateIndicatorState(hidden: true)
    }
    
    func updateIndicatorState(hidden: Bool) {
        DispatchQueue.main.async {
            self.indicatorView.isHidden = hidden
        }
    }
    
    func setData(args: BookDetailArguments) {
        DispatchQueue.main.async {
            self.thumbnailImageView.loadURL(url: args.thumbnail)
            self.bookTitleLabel.text = args.title
            self.authorLabel.text = args.author
            self.ratingTitleLabel.text = args.ratingCount
            self.ratingLabel.text = args.ratingAvarage
            self.categoryLabel.text = args.category
            self.pageLabel.text = args.page
            self.bookDescriptionLabel.text = args.description
        }
    }
}
