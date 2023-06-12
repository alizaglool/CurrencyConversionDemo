//
//  File.swift
//  
//
//  Created by Zaghloul on 03/06/2023.
//

import UIKit

public struct Alert {
    private static func createBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        alert.addAction(okButton)
        vc.present(alert, animated: true, completion: nil)
    }
    
    public static func failedToConnectWithServerAlert(on vc: UIViewController){
        createBasicAlert(on: vc, with: "", message: "حدث خطا ما يرجي المحاوله مره اخري")
    }
    
    public static func unauthorisedErrorAlert(on vc: UIViewController){
        createBasicAlert(on: vc, with: "", message: "رقم الهاتف او كلمه المرور غير صحيحة")
    }
    
    public static func defaultAlert(on vc: UIViewController, title: String = "", message: String){
        createBasicAlert(on: vc, with: title, message: message)
    }
    
    public static func createChoosePhotoType(on vc: UIViewController, completion: @escaping (PhotoSource) -> Void) {
        let alert = UIAlertController(title: "", message: "Choose your source", preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: "Camera", style: .default) { _ in
            completion(.camera)
        }
        let galleryButton = UIAlertAction(title: "Photo library", style: .default) {  _ in
            completion(.photoLibrary)
        }
        let okButton = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
        alert.addAction(cameraButton)
        alert.addAction(galleryButton)
        alert.addAction(okButton)
        vc.present(alert, animated: true, completion: nil)
    }
}

public enum PhotoSource {
    case camera
    case photoLibrary
}
