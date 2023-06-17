//
//  BaseAPI.swift
//  
//
//  Created by Zaghloul on 12/06/2023.
//

import Foundation
import Alamofire
import RxSwift
import UIKit

public class BaseAPI<T: TargetType> {
    
}

//MARK: - build Params -
//
extension BaseAPI {
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}

//MARK: - base api service -
//
extension BaseAPI {
    func connectWithServer<M: Decodable>(target: T, completion: @escaping (Result<M?, Error>) -> Void) {
        let url = target.baseURL + target.path
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Header.shared.createHeader()
        let params = buildParams(task: target.task)
        
        AF.request(url, method: method , parameters: params.0, encoding: params.1, headers: headers).validate().response { (response) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let json = try JSONDecoder().decode(M.self, from: data)
                    print(json)
                    completion(.success(json))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
}

