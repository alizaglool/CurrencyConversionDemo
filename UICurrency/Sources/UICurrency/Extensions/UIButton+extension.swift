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
    public func setPrimaryButton(background: UIColor = .black) {
        backgroundColor = background
        layer.cornerRadius = 8
        self.setTitleColor( UIColor.white, for: .normal)
        self.titleLabel?.textColor = UIColor.white
    }
}


