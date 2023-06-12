//
//  Header.swift
//  
//
//  Created by Zaghloul on 12/06/2023.
//

import Alamofire


struct Header {
    static let shared = Header()
    private init() {}
    
    func createHeader()-> HTTPHeaders? {
                
        let headers: HTTPHeaders =
        [
            "token": "",
            "token_secret": "",
            "default_lang": "en",
        ]
        
        return headers
    }
    
    
}
