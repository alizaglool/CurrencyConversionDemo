//
//  File.swift
//  
//
//  Created by Zaghloul on 15/06/2023.
//

import Foundation

public protocol CurrencyAPIProtocol {
    func getCurrencyType(completion: @escaping (Result<CurrencyModel?, Error>) -> Void)
}

public class CurrencyAPI: BaseAPI<CurrencyTarget>, CurrencyAPIProtocol {
    
    public override init() {}
}

// MARK: - Get Cuurncy -

extension CurrencyAPI {
    public func getCurrencyType(completion: @escaping (Result<CurrencyModel?, Error>) -> Void) {
        connectWithServer(target: .getCurencyType) { result in
            completion(result)
        }
    }
}
