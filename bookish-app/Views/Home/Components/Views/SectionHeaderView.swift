//
//  SectionTitleView.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import UIKit

protocol SectionHeaderViewDelegate: AnyObject {
    func onClickSeeMoreBtn()
}

final class SectionHeaderView: UICollectionReusableView {
    
    static let identifier = "SectionHeaderView"
    weak var delegate: SectionHeaderViewDelegate?
    
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title2(.semibold)
        label.text = "Title"
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var seeMoreBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("more", for: .normal)
        btn.titleLabel?.font = .Text1()
        btn.setTitleColor(.getColor(.moreBtnText), for: .normal)
        btn.addTarget(self, action: #selector(onClickSeeMoreBtn), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintUI() {
        self.addSubview(sectionTitleLabel)
        self.addSubview(seeMoreBtn)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.centerY.equalToSuperview()
        }
        seeMoreBtn.snp.makeConstraints { make in
            make.trailing.equalTo(0)
            make.centerY.equalToSuperview()
        }
    }
    
    func setup(title: String) {
        self.sectionTitleLabel.text = title
    }
    
    @objc func onClickSeeMoreBtn() {
        self.delegate?.onClickSeeMoreBtn()
    }
}
