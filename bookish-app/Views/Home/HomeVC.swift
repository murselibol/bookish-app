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
   func constraintsCollectionView()
}

final class HomeVC: UIViewController {
    private lazy var viewModel = HomeVM(view: self)
    weak var coordinator: HomeCoordinator?
    private var collectionView: UICollectionView!
    let categories = ["Fantasy", "Biography", "History", "Romance", "Science Fiction", "Dystopian"]

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
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: SectionHeaderView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
                case 0: return self.createPopularsSection()
                case 1: return self.createCategorySection()
                default: return self.createPopularsSection()
            }
        }
        
        
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func constraintsCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - UICollectionView
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 10
            case 1:
                return 6
            default:
                return 0
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.delegate = self
            cell.setup(categoryName: categories[indexPath.item])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
            case 0:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
                header.delegate = self
                header.setup(title: "Popular 🔥")
                return header
            default:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
                return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("OMG")
    }
}

// MARK: - SectionHeaderViewDelegate
extension HomeVC: SectionHeaderViewDelegate {
    func onClickSeeMoreBtn() {
        coordinator?.navigateBookListVC()
    }
}

// MARK: - SectionHeaderViewDelegate
extension HomeVC: CategoryCollectionViewCellDelegate {
    func onSelectCategory(category: String) {
        print(category)
    }
}

// MARK: - Compositional Layout
extension HomeVC {
    func createPopularsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = 20
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.37), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 10, bottom: 25, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Header", alignment: .top)
        header.contentInsets = .init(top: 0, leading: 0, bottom: 35, trailing: 0)
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
        section.contentInsets = .init(top: 0, leading: 10, bottom: 25, trailing: 10)
        
        return section
    }
}
