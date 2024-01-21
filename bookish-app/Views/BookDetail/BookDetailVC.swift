//
//  BookDetailVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import UIKit

protocol BookDetailVCDelegate: AnyObject {
    func configureCollectionViewLayout()
    func configureCollectionView()
    func constraintCollectionView()
    func reloadCollectionView()
    
    func constraintIndicatorView()
    func updateIndicatorState(hidden: Bool)
}

final class BookDetailVC: UIViewController {
    
    var viewModel: BookDetailVM!
    weak var coordinator: BookDetailCoordinator?
    private var collectionView: UICollectionView!
    
    private lazy var indicatorView = IndicatorView()
    
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
    
}

// MARK: - UICollectionViewDelegate
extension BookDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getMumberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookDetailCollectionViewCell.identifier, for: indexPath) as! BookDetailCollectionViewCell
        cell.bookDetailDelegate = self
        cell.setup(data: viewModel.book!)
        return cell
    }
}

// MARK: - BookDetailVCDelegate
extension BookDetailVC: BookDetailVCDelegate {
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookDetailCollectionViewCell.self, forCellWithReuseIdentifier: BookDetailCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            return self?.createDetailSection()
        }
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func constraintCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(0)
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

// MARK: - BookDetailDelegate
extension BookDetailVC: BookDetailDelegate {
    func onClickAuthor(authorName: String) {
        coordinator?.navigateAuthorBookListVC(authorName: authorName)
    }
}

// MARK: - Compositional Layout
extension BookDetailVC {
    func createDetailSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
