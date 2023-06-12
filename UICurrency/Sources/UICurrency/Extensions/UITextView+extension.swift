//
//  File.swift
//  
//
//  Created by Zaghloul on 07/05/2023.
//

import UIKit

//MARK: - primary text view -
//
extension UITextView {
    public func setPrimaryTextView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 6
        self.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 18)
        
        self.setPadding()
    }
}

//MARK: - set padding to text view -
//
extension UITextView {
    func setPadding(_ amount:CGFloat = 8) {
        self.textContainerInset = UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
    }
}

