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
    public let symbols: [Currency]?
    
    public init(success: Bool?, symbols: [Currency]?) {
        self.success = success
        self.symbols = symbols
    }
}

// MARK: - Currency
public struct Currency: Codable {
    public let code: String?
    public let name: String?
    
    public init(code: String?, name: String?) {
        self.code = code
        self.name = name
    }
}

public enum CurrencyCode: String, Codable {
    case aed = "AED"
    case afn = "AFN"
    case all = "ALL"
    case amd = "AMD"
    case ang = "ANG"
    case aog = "AOA"
    case ars = "ARS"
    case aud = "AUD"
    case avg = "AWG"
    // ...
    case zar = "ZAR"
    case zmk = "ZMK"
    case zmw = "ZMW"
    case zwz = "ZWL"
}
