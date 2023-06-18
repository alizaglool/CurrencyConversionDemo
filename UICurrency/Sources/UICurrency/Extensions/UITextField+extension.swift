//
//  File.swift
//  
//
//  Created by Zaghloul on 07/05/2023.
//

import UIKit

//MARK: - set primary text field -
//
extension UITextField {
    public func setPrimaryTextField() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 6
        self.backgroundColor = .white
        
        self.setRightPaddingPoints()
        self.setLeftPaddingPoints()
        self.textFieldEditingDidBegin()
        
        self.textColor = SystemDesign.AppColors.separator.color
        self.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 16)
        
    }
    
    @objc private func textFieldEditingDidBegin() {
        self.layer.borderColor = SystemDesign.AppColors.primary.color.cgColor
        self.layer.borderWidth = 1
    }
    @objc private func textFieldEditingDidEnd() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
    }
}

//MARK: - set Secondary text field -
//
extension UITextField {
    public func setSecondaryTextField() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        self.setRightPaddingPoints()
        self.setLeftPaddingPoints()
//                self.textFieldEditingDidBegin()
        
        self.textColor = .black
        
    }
    
}

// MARK: - Set Special Text Field -

extension UITextField {
    public func setSpecialTextField() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.08
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        self.backgroundColor = .white
        
        self.setRightPaddingPoints()
        self.setLeftPaddingPoints()
        self.textFieldEditingDidEnd()
        
        self.textColor = SystemDesign.AppColors.separator.color
        self.font = UIFont(name: SystemDesign.AppFonts.InterMedium.name, size: 16)
        
        let dummyView = UIView()
        self.inputView = dummyView
    }
}

//MARK: - set right / left padding to text field -
//
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat = 8) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat = 8) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

//MARK: - dismiss keyboard with return key in keyboard -
//
extension UITextField {
    @available(iOS 14.0, *)
    public func dismisskeyboardWithReturnKey() {
        self.addAction(UIAction(handler: { _ in
            self.endEditing(true)
        }), for: .primaryActionTriggered)
    }
}

//MARK: - handle keyboard with starting write in text field -
//
extension UITextField {
    @available(iOS 14.0, *)
    public func handleKeyboard(view: UIView) {
        self.addAction(UIAction(handler: { _ in
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= view.frame.height * 0.1
            }
        }), for: .editingDidBegin)
        
        self.addAction(UIAction(handler: { _ in
            if view.frame.origin.y != 0 {
                view.frame.origin.y = 0
            }
        }), for: .editingDidEnd)
    }
}

//MARK: - handle keyboard with starting write in text field with scroll view -
//
extension UITextField {
    @available(iOS 14.0, *)
    public func handleKeyboardWithScroll(position: CGFloat = 200, view: UIView, scrollView: UIScrollView) {
        
        self.addAction(UIAction(handler: { _ in
            if view.frame.origin.y == 0 {
                
                UIView.animate(withDuration: 0.7) {
                    scrollView.setContentOffset(CGPoint(x: 0, y: position), animated: false)
                }
            }
            
        }), for: .editingDidBegin)
        
        self.addAction(UIAction(handler: { _ in
            
            UIView.animate(withDuration: 0.7) {
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }), for: .editingDidEnd)
    }
}

//MARK: - create date picker -
//
extension UITextField {
    @available(iOS 13.4, *)
    public func createDatePickerView(datePicker: UIDatePicker, action: Selector, vc: UIViewController, maximumDate: Date? = Date()) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: vc, action: action)
        doneButton.tintColor = SystemDesign.AppColors.primary.color
        toolBar.setItems([doneButton], animated: true)
        self.inputAccessoryView = toolBar
        self.inputView = datePicker
        datePicker.tintColor = .yellow
        datePicker.maximumDate = maximumDate
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
}


