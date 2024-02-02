//
//  HomeCompostionalLayoutHelper.swift
//  bookish-app
//
//  Created by Mursel Elibol on 2.02.2024.
//

import UIKit

enum HomeSectionType: Int {
    case popular
    case category
    case book
    case rising
    case discover
    
    var sectionTitle: String {
        switch self {
            case .popular: return "Popular 🔥"
            case .book: return "Book of the Week ✨"
            case .rising: return "Rising 🚀"
            case .discover: return "Discover 🔎"
            default: return "Book"
        }
    }
    
    var sectionCategory: CategoryType {
        switch self {
            case .popular: return .history
            case .category: return .fantasy
            case .rising: return .love
            case .discover: return .philosophy
            default: return .fantasy
        }
    }
    
    func createLayoutSection() -> HomeCompostionalLayoutSection {
        switch self {
            case .popular: return HomeCompostionalLayoutSection(section: createPopularSection())
            case .category: return HomeCompostionalLayoutSection(section: createCategorySection())
            case .book: return HomeCompostionalLayoutSection(section: createBookSection())
            case .rising: return HomeCompostionalLayoutSection(section: createRisingSection())
            case .discover: return HomeCompostionalLayoutSection(section: createDiscoverSection())
        }
    }
}

// MARK: - HomeCompostionalLayout
struct HomeCompostionalLayoutSection {
    let section: NSCollectionLayoutSection
}

extension HomeSectionType {
    private func createPopularSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.24), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 10, bottom: 45, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.contentInsets.bottom = 15
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(100), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 10, bottom: 40, trailing: 10)
        
        return section
    }
    
    private func createBookSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 10, bottom: 50, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.contentInsets.bottom = 15
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createRisingSection() -> NSCollectionLayoutSection {
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
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.contentInsets.bottom = 15
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createDiscoverSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(130))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 10, bottom: 20, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.contentInsets.bottom = 15
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
