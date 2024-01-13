//
//  IndicatorView.swift
//  bookish-app
//
//  Created by Mursel Elibol on 13.01.2024.
//

import UIKit
import Lottie
import SnapKit

final class IndicatorView: UIView {
    
    private let lottieAnimationView = LottieAnimationView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        lottieAnimationView.animation = LottieAnimation.named("indicator")
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        
        addSubview(lottieAnimationView)
        lottieAnimationView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(self)
        }
    }
}
