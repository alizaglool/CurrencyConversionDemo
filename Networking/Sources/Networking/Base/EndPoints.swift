//
//  File.swift
//  
//
//  Created by Zaghloul on 12/06/2023.
//

import Foundation

public enum EndPoints: String {
    
    case baseURL = "http://97.74.85.114:1337/"
    case imagePath = "http://192.168.1.22:1337/files/driver/documents/"
    case apiKey = "AIzaSyAAhdz6VmDo7f8PWpQa4SI70S_bACudhE0"
    
    
    public var value: String {
        return self.rawValue
    }
}
