//
//  EmptyCollectionReuseView.swift
//  bookish-app
//
//  Created by Mursel Elibol on 1.02.2024.
//

import UIKit

final class EmptyCollectionReuseView: UICollectionReusableView {
    
    static let identifier = "SearchCollectionReuseView"
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
