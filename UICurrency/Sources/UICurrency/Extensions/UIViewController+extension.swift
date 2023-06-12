//
//  File.swift
//  
//
//  Created by Zaghloul on 07/05/2023.
//

import UIKit
import PDFKit

//MARK: - for dismiss Keyboard when tapped In View
//
extension UIViewController{
    public func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - add Tap Gesture To View -
//
extension UIViewController {
    public func addTapGestureToView(view: UIView, action: Selector?) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
}

//MARK: - add long Tap Gesture To View -
//
extension UIViewController {
    public func addlongGestureToView(view: UIView, action: Selector?) {
        let touchDown = UILongPressGestureRecognizer(target:self, action: action)
        touchDown.minimumPressDuration = 0
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(touchDown)
    }
    
    public func setBackgroundColorEffect(view: UIView, longGesture: UITapGestureRecognizer) {
        if longGesture.state == .began {
            view.backgroundColor = SystemDesign.AppColors.secondary.color
        } else if longGesture.state == .ended || longGesture.state == .cancelled {
            view.backgroundColor = .white
        }
    }
}

//MARK: - handle placeholder with textview -
//
extension UIViewController: UITextViewDelegate {
    public func handlePlaceholderTextView(textView: UITextView, placeholderText: String) {
        textView.delegate = self
        textView.text = placeholderText
        textView.textColor = SystemDesign.AppColors.separator.color
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == SystemDesign.AppColors.separator.color {
            textView.text = ""
            textView.textColor = SystemDesign.AppColors.secondary.color
        }
    }
}

//MARK: - hiden / show views -
//
extension UIViewController {
    public func showViews(views: [UIView]) {
        for view in views {
            view.isHidden = false
        }
    }
    
    public func hiddenViews(views: [UIView]) {
        for view in views {
            view.isHidden = true
        }
    }
}
//MARK: - Export Screen Pdf -
//
extension UIViewController {
    public func exportScreenAsPDF(from viewController: UIViewController, completion: @escaping (URL?) -> Void) {
        let pdfPageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4 size
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: pdfPageRect)
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("screen.pdf")
        
        do {
            try pdfRenderer.writePDF(to: fileURL) { (context) in
                context.beginPage()
                let contextBounds = context.pdfContextBounds
                let scale = min(contextBounds.width / viewController.view.bounds.width, contextBounds.height / viewController.view.bounds.height)
                context.cgContext.scaleBy(x: scale, y: scale)
                viewController.view.layer.render(in: context.cgContext)
            }
            print("PDF saved to: \(fileURL.path)")
            completion(fileURL)
        } catch {
            print("Error exporting PDF: \(error)")
            completion(nil)
        }
    }
    
    public func convertPdfToData(from view: UIView) -> Data? {
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: view.bounds)

        return pdfRenderer.pdfData { pdfContext in
            pdfContext.beginPage()

            let context = pdfContext.cgContext
            view.layer.render(in: context)
        }
    }
    
}
