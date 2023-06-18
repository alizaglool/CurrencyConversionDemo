//
//  File.swift
//  
//
//  Created by Zaghloul on 07/05/2023.
//

import UIKit

// MARK: - set Secondary text field -

extension UITextField {
    public func setSecondaryTextField() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        self.setRightPaddingPoints()
        self.setLeftPaddingPoints()
        self.textColor = .black
    }
}


// MARK: - set right / left padding to text field -

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat = 8) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat = 8) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

// MARK: - dismiss keyboard with return key in keyboard -

extension UITextField {
    @available(iOS 14.0, *)
    public func dismisskeyboardWithReturnKey() {
        self.addAction(UIAction(handler: { _ in
            self.endEditing(true)
        }), for: .primaryActionTriggered)
    }
}


