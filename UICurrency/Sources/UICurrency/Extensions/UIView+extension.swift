//
//  File.swift
//  
//
//  Created by Zahgloul on 07/05/2023.
//

import UIKit
import PDFKit

//MARK: - apply gradient for view -
//
extension UIView {
    public func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [SystemDesign.AppColors.primaryOP.color.cgColor, SystemDesign.AppColors.secondary.color.cgColor]
        gradientLayer.cornerRadius = 6
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 1)
    }
}

//MARK: - apply shadow for view -
//
extension UIView {
    public func applyShadow(cornerRadius: CGFloat = 8) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = true
    }
}

//MARK: - apply border for view -
//
extension UIView {
    public func applyBorder(borderColor: UIColor = SystemDesign.AppColors.primary.color, borderWidth: CGFloat = 1) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = 8.0
    }
}

//MARK: - apply border for view -
//
extension UIView {
    public func applyBorderWithMakeCircleView(borderColor: UIColor = SystemDesign.AppColors.primary.color, borderWidth: CGFloat = 1) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = self.frame.width / 2
    }
}

// MARK: - Apply Masks Corners -
//
extension UIView {
    public func applyMaskCorners(cornerRadius: CGFloat = 20) {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

// MARK: - Apply Masks Corners -
//
extension UIView {
    public func applyMaskCornersDown(cornerRadius: CGFloat = 20) {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}

// MARK: - Apply Masks Corners -
//
extension UIView {
    public func applyMaskCornersUp(cornerRadius: CGFloat = 20) {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

//MARK: - animation with view -
//
extension UIView {
    public func animated() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn) {
                
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { _ in
            }
        }
    }
}

//MARK: - make view is circle -
//
extension UIView {
    public func makeCircleView() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}

extension UIView {
    public func convertPdfToData(from view: UIView) -> Data? {
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: view.bounds)

        return pdfRenderer.pdfData { pdfContext in
            pdfContext.beginPage()

            let context = pdfContext.cgContext
            view.layer.render(in: context)
        }
    }
}

extension UIView {
    func applyShadowCell(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2.0
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

