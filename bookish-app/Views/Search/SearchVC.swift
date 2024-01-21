//
//  SearchVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 20.01.2024.
//

import UIKit

protocol SearchVCDelegate: AnyObject {
    func configureSearchTextField()
    func configureCollectionViewLayout()
    func configureCollectionView()
    func constraintCollectionView()
    func reloadCollectionView(scrollTop: Bool)

    func constraintIndicatorView()
    func updateIndicatorState(hidden: Bool)
}

final class SearchVC: UIViewController {
    
    lazy var viewModel: SearchVM = SearchVM(view: self)
    weak var coordinator: SearchCoordinator?
    private var collectionView: UICollectionView!
    private lazy var indicatorView = IndicatorView()
    
    lazy var searchTextField: SearchTextField = {
        let tf = SearchTextField()
        tf.placeholder = "book name, author, isbn..."
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .getColor(.background)
        viewModel.viewDidLoad()
    }
    
    deinit { coordinator?.finishCoordinator() }
    
}

// MARK: - UITextFieldDelegate
extension SearchVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.onChangeSearchTextField(text: textField.text ?? "")
    }
}

// MARK: - UICollectionViewDelegate
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.colletionViewWillDisplay(at: indexPath)
    }
}

// MARK: - SearchVCDelegate
extension SearchVC: SearchVCDelegate {
    func configureSearchTextField() {
        searchTextField.delegate = self
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            return self?.createListSection()
        }
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func constraintCollectionView() {
        view.addSubview(searchTextField)
        view.addSubview(collectionView)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func reloadCollectionView(scrollTop: Bool = false) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            if scrollTop {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
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
extension SearchVC: BookDelegate {
    func onClickBook(id: String) {
        coordinator?.navigateBookDetailVC(id: id)
    }
}

// MARK: - Compositional Layout
extension SearchVC {
    func createListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 10, bottom: 20, trailing: 10)
        
        return section
    }
}
