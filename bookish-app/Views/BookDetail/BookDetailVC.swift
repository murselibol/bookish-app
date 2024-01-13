//
//  BookDetailVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import UIKit

protocol BookDetailVCDelegate: AnyObject {
    func updateIndicatorState(hidden: Bool)
}

final class BookDetailVC: UIViewController {
    
    var viewModel: BookDetailVM!
    weak var coordinator: BookDetailCoordinator?
    
    private lazy var indicatorView = IndicatorView()
    
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
    
    // MARK: - Funtions
    func constraintIndicatorView() {
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        updateIndicatorState(hidden: true)
    }
    
}

// MARK: - BookDetailVCDelegate
extension BookDetailVC: BookDetailVCDelegate {
    func updateIndicatorState(hidden: Bool) {
        DispatchQueue.main.async {
            self.indicatorView.isHidden = hidden
        }
    }
}
