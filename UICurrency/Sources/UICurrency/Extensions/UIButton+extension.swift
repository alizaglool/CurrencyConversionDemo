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
    public func setPrimaryButton(background: UIColor = SystemDesign.AppColors.primary.color) {
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

//MARK: - set primary button be side secondary button -
//
extension UIButton {
    public func setPrimaryBesideSecondaryButton(backgroundColor: UIColor = SystemDesign.AppColors.primary.color) {
        layer.backgroundColor = backgroundColor.cgColor
        layer.cornerRadius = 8
        if LocalizationManager.shared.getLanguage() == .Arabic {
            layer.maskedCorners = [.layerMinXMaxYCorner]
        } else {
            layer.maskedCorners = [.layerMaxXMaxYCorner]
        }
        self.setTitleColor( UIColor.white, for: .normal)
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 16)
    }
}

//MARK: - set primary button be side secondary button -
//
extension UIButton {
    public func setSecondaryBesidePrimaryButton() {
        backgroundColor = SystemDesign.AppColors.secondaryOP.color
        layer.cornerRadius = 8
        if LocalizationManager.shared.getLanguage() == .Arabic {
            layer.maskedCorners = [.layerMaxXMaxYCorner]
        } else {
            layer.maskedCorners = [.layerMinXMaxYCorner]
        }
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.textColor = .black
        self.titleLabel?.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 16)
    }
}

// MARK: - Spicail Button -
//
extension UIButton {
    public func specialButton() {
        backgroundColor = SystemDesign.AppColors.primary.color
        layer.cornerRadius = 8
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.setTitleColor( UIColor.white, for: .normal)
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 16)
    }
}
//MARK: - check status button
//
extension UIButton {
    public func checkStatusButton(isEnabled: Bool) {
        self.isEnabled = isEnabled
        if isEnabled {
            titleLabel?.tintColor = .white
        }else {
            titleLabel?.tintColor = .lightGray
        }
    }
}
