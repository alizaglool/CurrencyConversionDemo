//
//  File.swift
//  
//
//  Created by Newsemicolon on 02/05/2023.
//

import UIKit

//MARK: - set primary button -
//
extension UIButton {
    public func setPrimaryButton(background: UIColor = .orange) {
        backgroundColor = background
        layer.cornerRadius = 8
        self.setTitleColor( UIColor.white, for: .normal)
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 16)
    }
}

//MARK: - set secondary button -
//
extension UIButton {
    public func setSecondaryButton() {
        backgroundColor = SystemDesign.AppColors.secondaryOP.color
        layer.cornerRadius = 8
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.textColor = .black
        self.titleLabel?.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 16)
    }
}


