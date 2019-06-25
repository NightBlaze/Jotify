//
//  Extensions.swift
//  Sticky Notes
//
//  Created by Harrison Leath on 5/8/19.
//  Copyright © 2019 Harrison Leath. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension String {
    func trunc(length: Int, trailing: String = "…") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
}

public extension CALayer {
    
    func addShadow(color: UIColor) {
        self.shadowOffset = .zero
        self.shadowOpacity = 0.3
        self.shadowRadius = 5
        self.shadowColor = color.cgColor
        self.masksToBounds = false
    }
}

extension UIView {
    func setGradient(){
        self.removeGradient()
        
        let gradientView = GradientAnimator(frame: self.frame, theme: Colors.shared.themeColor, _startPoint: GradientPoints.bottomLeft, _endPoint: GradientPoints.topRight, _animationDuration: 3.0)
        gradientView.tag = 007
        self.insertSubview(gradientView, at: 0)
        gradientView.startAnimate()
        
    }
    func removeGradient(){
        if let gradView : GradientAnimator = self.subviews.filter({$0.tag == 007}).first as? GradientAnimator{
            gradView.removeFromSuperview()
        }
    }
}

extension UIViewController {
    public var isVisible: Bool {
        if isViewLoaded {
            return view.window != nil
        }
        return false
    }
    
    public var isTopViewController: Bool {
        if self.navigationController != nil {
            return self.navigationController?.visibleViewController === self
        } else if self.tabBarController != nil {
            return self.tabBarController?.selectedViewController == self && self.presentedViewController == nil
        } else {
            return self.presentedViewController == nil && self.isVisible
        }
    }
}
