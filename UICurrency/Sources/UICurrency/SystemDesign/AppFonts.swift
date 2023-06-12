//
//  File.swift
//  
//
//  Created by Zaghloul on 26/04/2023.
//

import Foundation

extension SystemDesign {
    public enum AppFonts: String {
        case InterRegular = "Inter-Regular"
        case InterLight = "Inter-Light"
        case InterBold = "Inter-Bold"
        case InterMedium = "Inter-Medium"
        
       public var name: String {
            return self.rawValue
        }
    }
}
