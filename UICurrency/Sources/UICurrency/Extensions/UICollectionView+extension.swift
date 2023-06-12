//
//  File.swift
//  
//
//  Created by Zaghloul on 07/05/2023.
//

import UIKit

//MARK: - check if collection view is empty -
//
extension UICollectionView {
    public func checkIfDataIsEmpty(title: String, countOfData: Int) {
        switch countOfData {
        case 0:
            self.setNoResultMessage(title: title)
        default:
            self.clearBackground()
        }
    }
}

//MARK: - set no result message -
//
extension UICollectionView {
    func setNoResultMessage(title: String) {
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = title
        lblMessage.textColor = SystemDesign.AppColors.separator.color
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        lblMessage.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 18)
        lblMessage.sizeToFit()
        lblMessage.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        self.backgroundView = lblMessage
    }

    func clearBackground() {
        self.backgroundView = nil
    }
}
