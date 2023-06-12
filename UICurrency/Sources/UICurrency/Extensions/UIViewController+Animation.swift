//
//  File.swift
//  
//
//  Created by Zaghloul on 07/05/2023.
//

import UIKit

//MARK: - dismiss view with animation -
//
extension UIViewController {
    public func dismissViewWithAnimation(view: UIView) {
        UIView.animate(withDuration: 1) {
            view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        }
        self.dismiss(animated: true)
    }
}

//MARK: - dismiss view when tapped around -
//
extension UIViewController {
    public func dismissViewWhenTappedAround(subView: UIView) {
        addTapGestureToView(view: self.view, action: #selector(viewTapped))
        addTapGestureToView(view: subView, action: #selector(supViewTapped))
    }
    
    @objc private func viewTapped() {
        dismiss(animated: true)
    }
    @objc private func supViewTapped() {
        print(Self.self)
    }
}

//MARK: - animation when open view -
//
extension UIViewController {
    public func makeViewVisible(view: UIView) {
        view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
    }
    
    public func animationWhenOpenView(view: UIView) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8) {
                view.transform = .identity
            }
        }
    }
}

