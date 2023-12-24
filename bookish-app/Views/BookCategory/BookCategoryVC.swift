//
//  BookCategoryVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 24.12.2023.
//

import UIKit

class BookCategoryVC: UIViewController {

    let helloText: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.Raleway(.semibold, size: 30)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(helloText)
        
        helloText.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
