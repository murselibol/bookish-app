//
//  AuthorBookListVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 21.01.2024.
//

import UIKit

protocol AuthorBookListVCDelegate: AnyObject {
    func configureCollectionViewLayout()
    func configureCollectionView()
    func constraintCollectionView()
    func reloadCollectionView()
    
    func constraintIndicatorView()
    func updateIndicatorState(hidden: Bool)
}

final class AuthorBookListVC: UIViewController {
    
    var viewModel: AuthorBookListVM!
    weak var coordinator: AuthorBookListCoordinator?
    private var collectionView: UICollectionView!
    
    private lazy var indicatorView = IndicatorView()
    
    init(authorName: String) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = AuthorBookListVM(view: self, authorName: authorName)
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
    
}

// MARK: - UICollectionViewDelegate
extension AuthorBookListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookListCollectionViewCell.identifier, for: indexPath) as! BookListCollectionViewCell
        cell.bookDelegate = self
        let book = viewModel.books[indexPath.item].volumeInfo
        let id = viewModel.books[indexPath.item].id ?? ""
        let thumbnailUrl = book?.imageLinks?.smallThumbnail
        let title = book?.title ?? "-"
        let author = book?.authors?.first ?? "-"
        let description = book?.description ?? "-"
        cell.setup(data: DiscoverSectionModel(id: id, thumbnailUrl: thumbnailUrl, title: title, author: author, description: description))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReuseView.identifier, for: indexPath) as! TitleCollectionReuseView
        header.setup(title: "Paulo Coelho", sectionIndex: indexPath.section, hiddenSeeMore: true)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.colletionViewWillDisplay(at: indexPath)
    }
}

// MARK: - AuthorBookListVCDelegate
extension AuthorBookListVC: AuthorBookListVCDelegate {
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.identifier)
        collectionView.register(TitleCollectionReuseView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: TitleCollectionReuseView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            return self?.createListSection()
        }
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func constraintCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
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
}

// MARK: - Book Delegate
extension AuthorBookListVC: BookDelegate {
    func onClickBook(id: String) {
        coordinator?.navigateBookDetailVC(id: id)
    }
}

// MARK: - Compositional Layout
extension AuthorBookListVC {
    func createListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 20, leading: 10, bottom: 20, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

