//
//  BookDetailVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import UIKit

protocol BookDetailVCDelegate: AnyObject {
    
}

final class BookDetailVC: UIViewController {
    lazy var viewModel = BookDetailVM(view: self)
    weak var coordinator: BookDetailCoordinator?
    
    private lazy var pageName: UILabel = {
        let label = UILabel()
        label.text = "BookDetail"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .getColor(.background)
        
        view.addSubview(pageName)
        pageName.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    deinit { coordinator?.finishCoordinator() }
    
}

extension BookDetailVC: BookDetailVCDelegate {
    
}
