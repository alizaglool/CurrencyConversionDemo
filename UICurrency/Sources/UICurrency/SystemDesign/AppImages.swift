//
//  File.swift
//  
//
//  Created by Zaghloul on 26/04/2023.
//

import UIKit

extension SystemDesign {
    public enum AppImages: String {
        case firstOnboarding = "first_onboarding"
        case secondOnboarding = "second_onboarding"
        case thirdOnboarding = "third_onboarding"
        case SemicolonDarkmain2 = "Semicolon-darkmain2"
        case logo, Arrpwdown, truckLine
        case logoLogin = "logo_login"
        case rigesterIcon, startPoint
        case meun, avater, endPoint
        case home, about, ArrowDownPer
        case requests, logout
        case ArrowRight, pen, flag
        case Shipments, language
        case PersonalInformation
        case PrivacyPolicy = "Privacy_policy"
        case TermsCondition = "Terms_Condition"
        case estimationDistance, pickup
        case estimationtime, dropoff, setLocation
        case done, noData, truck, pdf, line
        case Docs, Balance, shipmentDriver, select
        case nobankDetails, add, background
        case selectFill = "select-fill"
        case NoDataCuate, favorite, work, Location
 
        //return name of image
        public var name: String {
            return self.rawValue
        }
        
        //return image
        public var image: UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
}

extension SystemDesign {
    public enum SystemImages: String {
        
        case person = "person.circle"
        case card = "cart.circle"
        case bell
        case house = "house.circle"
        case search = "magnifyingglass"
        case calendar
        case circleCheck = "circle.fill"
        case circleUncheck = "circle"
        case Language = "globe"
        case arrowRight = "arrow.right"

        
        
        //return name of image
        public var name: String {
            return self.rawValue
        }
        
        //return image
        @available(iOS 13.0, *)
        public var image: UIImage {
            return UIImage(systemName: self.rawValue) ?? UIImage()
        }
    }
}
