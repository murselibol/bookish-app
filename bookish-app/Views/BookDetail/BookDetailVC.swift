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
    
    var viewModel: BookDetailVM!
    weak var coordinator: BookDetailCoordinator?
    
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

extension BookDetailVC: BookDetailVCDelegate {
    
}
