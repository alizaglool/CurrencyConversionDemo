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
}

extension CurrencyTarget: TargetType {
    
    
    public var baseURL: String {
        return EndPoints.baseURL.value
    }
    
    public var path: String {
        switch self {
        case .getCurencyType:
            return "symbols?access_key=\(EndPoints.apiKey.value)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getCurencyType:
            return .get
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

