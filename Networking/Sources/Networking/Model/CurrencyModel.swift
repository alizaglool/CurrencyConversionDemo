//
//  File.swift
//  
//
//  Created by Zaghloul on 15/06/2023.
//

import Foundation

// MARK: - Currency Model

public struct CurrencyModel: Codable {
    public let success: Bool?
    public let symbols: [String: String]?

    enum CodingKeys: String, CodingKey {
        case success
        case symbols
    }
    
    public init(success: Bool?, symbols: [String : String]?) {
        self.success = success
        self.symbols = symbols
    }
}

public struct Currency: Codable {
    public let code: String
    public let name: String
}
//public struct Currency: Codable {
//    public let code: String?
//    public let name: String?
//
//    public init(code: String?, name: String?) {
//        self.code = code
//        self.name = name
//    }
//}
//public struct CurrencyModel: Codable {
//    public let success: Bool
//    public let symbols: [Currency]
//    
//    enum CodingKeys: String, CodingKey {
//        case success
//        case symbols
//    }
//
//}
//
//public struct Currency: Codable {
//    public let code: String
//    public let name: String
//}
