//
//  File.swift
//  
//
//  Created by Zaghloul on 12/06/2023.
//

import Foundation

public enum EndPoints: String {
    
    case baseURL = "http://data.fixer.io/api/"
    case apiKey = "573361bb78ff2665f4a331f4e8e0e780"
    
    public var value: String {
        return self.rawValue
    }
}
