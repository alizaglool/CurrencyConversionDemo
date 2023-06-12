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

public struct ImageRequest {
    public var imageData: Data?
    public var imageName: String
    
    public init(imageData: Data? = nil, imageName: String) {
        self.imageData = imageData
        self.imageName = imageName
    }
}

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

//MARK: - base api to upload images -
//
extension BaseAPI {
    func uploadImages<M: Decodable>(target: T, images: [ImageRequest], completion: @escaping (Result<M?, Error>) -> Void) {
        let url = target.baseURL + target.path
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let params = buildParams(task: target.task).0
        let headers = Header.shared.createHeader()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for image in images {
                multipartFormData.append(image.imageData ?? Data(), withName: "\(image.imageName)", fileName: "\(image.imageName).jpeg", mimeType: "\(image.imageName)/jpeg")
            }
            
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: url, method: method , headers: headers)
        
        .responseDecodable(of: M.self) { response in
            debugPrint(response)
            guard let data = response.data else { return }
            do {
                let json = try JSONDecoder().decode(M.self, from: data)
                completion(.success(json))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

//MARK: - base api to upload single image -
//
extension BaseAPI {
    func uploadImage<M: Decodable>(target: T, image: Data?, completion: @escaping (M?) -> Void) {
        let url = target.baseURL + target.path
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let params = buildParams(task: target.task).0
        let headers = Header.shared.createHeader()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(image ?? Data(), withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: url, method: method , headers: headers)
        
        .responseDecodable(of: M.self) { response in
            debugPrint(response)
            completion(response.value)
        }
    }
}

//MARK: - upload images with response model -
//
extension BaseAPI {
    func uploadImages<M: Decodable>(target: T, images: [ImageRequest], completion: @escaping (M?) -> Void) {
        let url = target.baseURL + target.path
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let params = buildParams(task: target.task).0
        let headers = Header.shared.createHeader()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for image in images {
                multipartFormData.append(image.imageData ?? Data(), withName: "\(image.imageName)", fileName: "\(image.imageName).jpeg", mimeType: "\(image.imageName)/jpeg")
            }
            
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: url, method: method , headers: headers)
        
        .responseDecodable(of: M.self) { response in
            debugPrint(response)
            completion(response.value)
        }
    }
}

//MARK: - upload images with response and string error model -
//
extension BaseAPI {
    func uploadImages<M: Decodable>(target: T, images: [ImageRequest], completion: @escaping (M?, String?) -> Void) {
        let url = target.baseURL + target.path
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let params = buildParams(task: target.task).0
        let headers = Header.shared.createHeader()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for image in images {
                multipartFormData.append(image.imageData ?? Data(), withName: "\(image.imageName)", fileName: "\(image.imageName).jpeg", mimeType: "\(image.imageName)/jpeg")
            }
            
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: url, method: method , headers: headers)
        
        .responseDecodable(of: M.self) { response in
            debugPrint(response)
            guard let data = response.data else { return }
            if let json = try? JSONDecoder().decode(M.self, from: data) {
                completion(json, nil)
            } else if let str = try? JSONDecoder().decode(String.self, from: data) {
                completion(nil, str)
            } else {
                completion(nil, ErrorMessage.ErrorOccure.rawValue)
            }
        }
    }
}

extension BaseAPI {
    func fetchMapImage(body: StaticMapBody, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let baseUrl = "https://maps.googleapis.com/maps/api/staticmap?"
        let center = "center=color:red%7Clabel:0.7810026511490191%7C\(body.pickupLat),\(body.pickupLon)"
        let marker1 = "markers=color:red%7Clabel:0.7810026511490191%7C\(body.pickupLat),\(body.pickupLon)"
        let marker2 = "markers=color:red%7Clabel:0.7810026511490191%7C\(body.dropLat),\(body.dropLon)"
        let zoom = "zoom=null"
        let size = "size=\(body.width)x\(body.height)"
        let mapType = "maptype=roadmap"
        let apiKey = EndPoints.apiKey.value
        let urlString = "\(baseUrl)\(marker1)&\(marker2)&\(center)&\(zoom)&\(size)&\(mapType)&key=\(apiKey)"
        guard let url = URL(string: urlString ) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data, let mapImage = UIImage(data: data) {
                completion(.success(mapImage))
            } else {
                let error = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch map image"])
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

