//
//  File.swift
//  
//
//  Created by Zaghloul on 18/06/2023.
//

import Foundation

// MARK: - Conversion Model -

public struct ConversionModel: Codable {
    public let success: Bool
    public let query: Query
    public let info: Info
    public let historical: String?
    public let date: String
    public let result: Double
}

// MARK: - Query Model -

public struct Query: Codable {
    public let from: String
    public let to: String
    public let amount: Int
}

// MARK: - Info Model -

public struct Info: Codable {
    public let timestamp: Int
    public let rate: Double
}
