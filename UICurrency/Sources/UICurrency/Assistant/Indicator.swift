//
//  File.swift
//  
//
//  Created by Zaghloul on 07/05/2023.
//

import UIKit

@available(iOS 13.0, *)
public struct Indicator {
    
    static let indicator = UIActivityIndicatorView(style: .large)
    @available(iOS 13.0, *)
    public static func createIndicator(on vc: UIViewController, start: Bool) {
        DispatchQueue.main.async {
            indicator.center = vc.view.center
            indicator.color = SystemDesign.AppColors.secondary.color
            vc.view.addSubview(indicator)
            if start {
                indicator.startAnimating()
            }else {
                indicator.stopAnimating()
            }
        }
    }
}
