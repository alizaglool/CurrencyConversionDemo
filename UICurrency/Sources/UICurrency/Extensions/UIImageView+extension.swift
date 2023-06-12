//
//  File.swift
//  
//
//  Created by Newsemicolon on 02/05/2023.
//

import UIKit

//MARK: - animation (show image view form empty) -
//
extension UIImageView {
    public func animationShowImageFormEmpty(time: TimeInterval = 0.5) {
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: time) { [weak self] in
                guard let self = self else { return }
                self.transform = .identity
            }
        }
    }
}
