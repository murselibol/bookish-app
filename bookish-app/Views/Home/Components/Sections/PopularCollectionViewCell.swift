//
//  PopularsCollectionViewCell.swift
//  bookish-app
//
//  Created by Mursel Elibol on 7.01.2024.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCollectionViewCell"
    
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.text = "Populars Collection View Cell"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintUI() {
        addSubview(cellLabel)
        
        cellLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
