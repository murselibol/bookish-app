//
//  EmptyCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 1.02.2024.
//

import UIKit

final class EmptyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EmptyCollectionViewCell"

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

