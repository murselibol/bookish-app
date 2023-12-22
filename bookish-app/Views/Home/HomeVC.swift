//
//  HomeVC.swift
//  bookish-app
//
//  Created by Mursel Elibol on 22.12.2023.
//

import UIKit
import SnapKit


final class HomeVC: UIViewController {
    
    let helloText: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .cyan
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
