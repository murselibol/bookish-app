//
//  UIView+Ext.swift
//  bookish-app
//
//  Created by Mursel Elibol on 10.02.2024.
//

import UIKit


extension UIView {
    
    // MARK: - OPACITY
    func addLongPressOpacity() {
        lazy var tapGesture: UILongPressGestureRecognizer = {
            let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(opacityHandler(_:)))
            tapGesture.minimumPressDuration = 0.1
            tapGesture.view?.clipsToBounds = true
            return tapGesture
        }()
        
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func opacityHandler(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            self.alpha = CGFloat(0.65)
        } else if gestureRecognizer.state == .cancelled || gestureRecognizer.state == .ended {
            self.alpha = CGFloat(1.0)
            if let tapGesture = self.gestureRecognizers?.first(where: { $0 is UITapGestureRecognizer }) as? UITapGestureRecognizer,
               gestureRecognizer.location(in: self).isContained(in: self.bounds) {
                tapGesture.state = .ended
            }
        }
    }
    
    // MARK: - RIPPLE
    func addLongPressRipple(color: UIColor = .clear, alpha: CGFloat = 0.7, duration: TimeInterval = 0.7) {
        lazy var tapGesture: RippleUILongPressGestureRecognizer = {
            let tapGesture = RippleUILongPressGestureRecognizer(target: self, action: #selector(rippleHandler(_:)))
            tapGesture.rippleColor = color
            tapGesture.rippleAlpha = alpha
            tapGesture.rippleDuration = duration
            tapGesture.minimumPressDuration = 0.1
            tapGesture.view?.clipsToBounds = true
            return tapGesture
        }()
        
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func rippleHandler(_ gestureRecognizer: RippleUILongPressGestureRecognizer) {
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
            
            if let tapGesture = gestureRecognizerView.gestureRecognizers?.first(where: { $0 is UITapGestureRecognizer }) as? UITapGestureRecognizer,
               tapLocation.isContained(in: gestureRecognizerView.bounds) {
                tapGesture.state = .ended
            }
        }
    }
}

// MARK: - UILongPressGestureRecognizer for RippleView
final class RippleUILongPressGestureRecognizer: UILongPressGestureRecognizer {
    var rippleColor: UIColor = .clear
    var rippleAlpha: CGFloat = 0.7
    var rippleDuration: TimeInterval = 0.7
}
