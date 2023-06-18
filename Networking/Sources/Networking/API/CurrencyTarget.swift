//
//  File.swift
//  
//
//  Created by Zaghloul on 15/06/2023.
//

import Foundation
import Alamofire

public enum CurrencyTarget {
    case getCurencyType
    case conversionAmount(from: String, to: String, amount: String)
}

extension CurrencyTarget: TargetType {
    
    
    public var baseURL: String {
        return EndPoints.baseURL.value
    }
    
    public var path: String {
        switch self {
        case .getCurencyType:
            return "symbols?access_key=\(EndPoints.apiKey.value)"
        case .conversionAmount(from: let base , to: let target, amount: let amount):
            return "convert?access_key=\(EndPoints.apiKey.value)&from=\(base)&to=\(target)&amount=\(amount)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getCurencyType:
            return .get
        case .conversionAmount:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return [:]
    }
    
}

