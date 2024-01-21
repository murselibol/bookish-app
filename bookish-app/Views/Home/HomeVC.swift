//
//  HomeVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 22.12.2023.
//

import UIKit
import SnapKit

protocol HomeVCDelegate: AnyObject {
    
    func configureCollectionViewLayout()
    func configureCollectionView()
    func constraintCollectionView()
    func reloadCollectionView()
    
    func constraintIndicatorView()
    func updateIndicatorState(hidden: Bool)
}

final class HomeVC: UIViewController {
    private lazy var viewModel = HomeVM(view: self)
    weak var coordinator: HomeCoordinator?
    
    private var collectionView: UICollectionView!
    private lazy var indicatorView = IndicatorView()

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

// MARK: - HomeVCDelegate
extension HomeVC: HomeVCDelegate {
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        collectionView.register(RisingCollectionViewCell.self, forCellWithReuseIdentifier: RisingCollectionViewCell.identifier)
        collectionView.register(DiscoverCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverCollectionViewCell.identifier)
        collectionView.register(TitleCollectionReuseView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: TitleCollectionReuseView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
                case 0: return self?.createPopularSection()
                case 1: return self?.createCategorySection()
                case 2: return self?.createBookSection()
                case 3: return self?.createRisingSection()
                case 4: return self?.createDiscoverSection()
                default: return self?.createPopularSection()
            }
        }
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func constraintCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func constraintIndicatorView() {
        view.addSubview(indicatorView)
//        indicatorView.layer.zPosition = 99
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

// MARK: - UICollectionView
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return viewModel.popularBooks.count
            case 1:
                return viewModel.categories.count
            case 2:
                return 1
            case 3:
                return viewModel.risingBooks.count
            case 4:
                return viewModel.discoverBooks.count
            default:
                return 0
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
            cell.bookClickListener = self
            let book = viewModel.popularBooks[indexPath.item].volumeInfo
            let id = viewModel.popularBooks[indexPath.item].id ?? ""
            let thumbnailUrl = book?.imageLinks?.smallThumbnail
            let title = book?.title ?? "-"
            cell.setup(data: PopularSectionModel(id: id, thumbnailUrl: thumbnailUrl, title: title))
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.delegate = self
            cell.setup(data: viewModel.categories[indexPath.item])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
            cell.bookClickListener = self
            let book = viewModel.bookOfWeak?.volumeInfo
            let id = viewModel.bookOfWeak?.id ?? ""
            let thumbnailUrl = book?.imageLinks?.smallThumbnail
            let title = book?.title ?? "-"
            let description = book?.description ?? "-"
            cell.setup(data: BookSectionModel(id: id, thumbnailUrl: thumbnailUrl, title: title, description: description))
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RisingCollectionViewCell.identifier, for: indexPath) as! RisingCollectionViewCell
//            indexPath.item == 1 ? (cell.backgroundColor = .purple) : (cell.backgroundColor = .systemPink)
            cell.bookClickListener = self
            cell.authorClickListener = self
            let book = viewModel.risingBooks[indexPath.item].volumeInfo
            let id = viewModel.risingBooks[indexPath.item].id ?? ""
            let thumbnailUrl = book?.imageLinks?.smallThumbnail
            let title = book?.title ?? "-"
            let author = book?.authors?.first ?? "-"
            cell.setup(data: RisingSectionModel(id: id, thumbnailUrl: thumbnailUrl, rank: "0\(indexPath.item+1)", title: title, author: author))
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCollectionViewCell.identifier, for: indexPath) as! DiscoverCollectionViewCell
            cell.bookClickListener = self
            cell.authorClickListener = self
            let book = viewModel.discoverBooks[indexPath.item].volumeInfo
            let id = viewModel.discoverBooks[indexPath.item].id ?? ""
            let thumbnailUrl = book?.imageLinks?.smallThumbnail
            let title = book?.title ?? "-"
            let author = book?.authors?.first ?? "-"
            let description = book?.description ?? "-"
            cell.setup(data: DiscoverSectionModel(id: id, thumbnailUrl: thumbnailUrl, title: title, author: author, description: description))
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
            case 0:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReuseView.identifier, for: indexPath) as! TitleCollectionReuseView
                header.delegate = self
                header.setup(title: HomeSectionType.popular.sectionTitle, sectionIndex: indexPath.section)
                return header
            case 2:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReuseView.identifier, for: indexPath) as! TitleCollectionReuseView
                header.delegate = self
                header.setup(title: HomeSectionType.book.sectionTitle, sectionIndex: indexPath.item, hiddenSeeMore: true)
                return header
            case 3:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReuseView.identifier, for: indexPath) as! TitleCollectionReuseView
                header.delegate = self
                header.setup(title: HomeSectionType.rising.sectionTitle, sectionIndex: indexPath.section)
                return header
            case 4:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReuseView.identifier, for: indexPath) as! TitleCollectionReuseView
                header.delegate = self
                header.setup(title: HomeSectionType.discover.sectionTitle, sectionIndex: indexPath.section)
                return header
            default:
                return UICollectionReusableView()
        }
    }
}

// MARK: - Compositional Section Header Delegate
extension HomeVC: TitleCollectionReuseViewDelegate {
    func onClickSeeMoreBtn(sectionIndex: Int) {
        let category = HomeSectionType.discover.sectionCategory
        let title = HomeSectionType.discover.sectionTitle
        coordinator?.navigateBookListVC(title: title, category: category)
    }
}

// MARK: - BookClickListener
extension HomeVC: BookClickListener {
    func onClickBook(id: String) {
        coordinator?.navigateBookDetailVC(id: id)
    }
}
// MARK: - AuthorClickListener
extension HomeVC: AuthorClickListener {
    func onClickAuthor(authorName: String) {
        coordinator?.navigateAuthorBookListVC(authorName: authorName)
    }
}


// MARK: - Category Section Delegate
extension HomeVC: CategoryCollectionViewCellDelegate {
    func onSelectCategory(category: CategoryType) {
        coordinator?.navigateBookListVC(title: category.title, category: category)
    }
}

// MARK: - Compositional Layout
extension HomeVC {
    func createPopularSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.24), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 10, bottom: 45, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
        header.contentInsets.bottom = 15
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(100), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 10, bottom: 50, trailing: 10)
        
        return section
    }
    
    func createBookSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 10, bottom: 50, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
        header.contentInsets.bottom = 15
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createRisingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .absolute(400))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item, item])
        group.interItemSpacing = .fixed(20)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 50
        section.contentInsets = .init(top: 0, leading: 10, bottom: 50, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
        header.contentInsets.bottom = 15
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createDiscoverSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 10, bottom: 20, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
        header.contentInsets.bottom = 15
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
