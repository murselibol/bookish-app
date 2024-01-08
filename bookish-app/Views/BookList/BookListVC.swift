//
//  BookListVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import UIKit

final class BookListVC: UIViewController {
    
    weak var coordinator: BookListCoordinator?
    
    private lazy var pageName: UILabel = {
        let label = UILabel()
        label.text = "BookListVC"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pageName)
        pageName.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    deinit { coordinator?.finishCoordinator() }
    
}
