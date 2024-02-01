//
//  SectionTitleView.swift
//  bookish-app
//
//  Created by Mursel Elibol on 8.01.2024.
//

import UIKit

protocol TitleCollectionReuseViewDelegate: AnyObject {
    func onClickSeeMoreBtn(sectionIndex: Int)
}

final class TitleCollectionReuseView: UICollectionReusableView {
    
    static let identifier = "TitleCollectionReuseView"
    weak var delegate: TitleCollectionReuseViewDelegate?
    private var sectionIndex: Int!
    
    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title2(.semibold)
        label.text = "Title"
        label.textColor = .getColor(.bookTitle)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var seeMoreContainerBtn: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickSeeMoreBtn)))
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var seeMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "more"
        label.font = .Text1()
        label.textColor = .getColor(.moreBtnText)
        return label
    }()
    
    private lazy var seeMoreIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .getColor(.textGray)
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraintUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraint
    private func constraintUI() {
        addSubview(sectionTitleLabel)
        addSubview(seeMoreContainerBtn)
        seeMoreContainerBtn.addSubview(seeMoreLabel)
        seeMoreContainerBtn.addSubview(seeMoreIcon)
        
        sectionTitleLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
        seeMoreContainerBtn.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        seeMoreLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.trailing.equalTo(seeMoreIcon.snp.leading).offset(-5)
        }
        
        seeMoreIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview().offset(1)
            make.height.equalTo(16)
            make.width.equalTo(12)
        }
    }
    
    // MARK: - Functions
    func setup(data: TitleCollectionReuseViewArguments) {
        self.sectionIndex = data.sectionIndex
        self.sectionTitleLabel.text = data.title
        isHiddenSeeMoreBtn(hidden: data.hiddenSeeMore)
    }
    
    @objc private func onClickSeeMoreBtn() {
        self.delegate?.onClickSeeMoreBtn(sectionIndex: sectionIndex)
    }
    
    private func isHiddenSeeMoreBtn(hidden: Bool) {
        seeMoreContainerBtn.isHidden = hidden
    }
}
