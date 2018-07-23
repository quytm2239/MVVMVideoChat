//
//  UITextField.swift
//  TourDe
//
//  Created by Tran Manh Quy on 4/3/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setupDoneDismiss() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissKeyboard))
        doneBarButton.tintColor = UIColor.blue
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
    
    @objc func dismissKeyboard() {
        if self.isFirstResponder {
            self.resignFirstResponder()
        }
    }
    
}
