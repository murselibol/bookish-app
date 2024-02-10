//
//  UIView+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 10.02.2024.
//

import UIKit

extension UIView {
    func addRippleEffect(color: UIColor = .clear, alpha: CGFloat = 0.7, duration: TimeInterval = 1.0) {
        lazy var tapGesture: RippleUILongPressGestureRecognizer = {
            let tapGesture = RippleUILongPressGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
            tapGesture.rippleColor = color
            tapGesture.rippleAlpha = alpha
            tapGesture.rippleDuration = duration
            tapGesture.minimumPressDuration = 0.2
            tapGesture.view?.clipsToBounds = true
            return tapGesture
        }()
        
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapHandler(_ gestureRecognizer: RippleUILongPressGestureRecognizer) {
        guard let gestureRecognizerView = gestureRecognizer.view else { return }
        let tapLocation = gestureRecognizer.location(in: gestureRecognizerView)
        let size = max(gestureRecognizerView.frame.width, gestureRecognizerView.frame.height)
        let animateSize = size * 2
        lazy var rippleView: UIView = {
            let v = UIView()
            v.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            v.center = tapLocation
            v.alpha = gestureRecognizer.rippleAlpha
            v.backgroundColor = gestureRecognizer.rippleColor
            v.isUserInteractionEnabled = false
            v.restorationIdentifier = "ripple"
            return v
        }()
        if gestureRecognizer.state == .began {
            gestureRecognizerView.insertSubview(rippleView, at: 0)
            
            UIView.animate(withDuration: gestureRecognizer.rippleDuration, animations: {
                rippleView.frame.size = CGSize(width: animateSize, height: animateSize)
                rippleView.center = tapLocation
                rippleView.layer.cornerRadius = animateSize/2
            })
        } else if gestureRecognizer.state == .cancelled || gestureRecognizer.state == .ended {
            gestureRecognizerView.subviews.forEach { $0.restorationIdentifier == "ripple" ? $0.removeFromSuperview() : nil }
        }
    }
}

// MARK: - UILongPressGestureRecognizer for RippleView
final class RippleUILongPressGestureRecognizer: UILongPressGestureRecognizer {
    var rippleColor: UIColor = .clear
    var rippleAlpha: CGFloat = 0.7
    var rippleDuration: TimeInterval = 1.0
}
