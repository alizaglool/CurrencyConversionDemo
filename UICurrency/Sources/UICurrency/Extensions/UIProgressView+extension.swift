//
//  File.swift
//  
//
//  Created by Zaghloul on 07/05/2023.
//

import UIKit

//MARK: - progress view -
//
extension UIProgressView {
    public func animationWithProgressView(startPoint: Float, endPoint: Float) {
        // stop any current animation
        self.layer.sublayers?.forEach { $0.removeAllAnimations() }
        
        // reset progressView to 100%
        self.setProgress(startPoint, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // set progressView to 0%, with animated set to false
            self.setProgress(endPoint, animated: false)
            // 10-second animation changing from strat to end
            UIView.animate(withDuration: 4, delay: 0, options: [], animations: { [unowned self] in
                self.layoutIfNeeded()
            })
        }
    }
}
