//
//  File.swift
//  
//
//  Created by Zaghloul on 26/04/2023.
//

import UIKit

extension SystemDesign {
    public enum AppColors: String {
        case primary
        case secondary
        case separator
        case primaryOP
        case tabBar, gray
        case secondaryOP, green
        case secondaryPro
        case thirdty
        case locationc
        case secondarypr = "secondarypro%"
        
        public var color: UIColor {
            return UIColor(named: self.rawValue) ?? UIColor()
        }
    }
}
