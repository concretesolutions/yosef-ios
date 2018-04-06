//
//  TextFieldComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class DynamicTextField: UITextField {
    public var action: String?
}


class TextFieldComponent: NSObject, PropertyBasedViewComponent {
    func createView() -> UITextField {
        let textField = DynamicTextField()
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }
    
    var propertyDictionary: [String: AnyPropertyApplier<UITextField>] =
        ["text": AnyPropertyApplier(KeyPathApplier(\UITextField.text)),
         "textColor": AnyPropertyApplier(KeyPathApplier(\UITextField.textColor)),
         "placeholder": AnyPropertyApplier(KeyPathApplier(\UITextField.placeholder))]
    
    fileprivate let kTextFieldComponentType = "textField"
    fileprivate let kTextFieldComponentLeadingConstraint = CGFloat(16)
    fileprivate let kTextFieldComponentTrailingConstraint = CGFloat(-16)
    fileprivate let kTextFieldComponentTopConstraint = CGFloat(50)
    fileprivate let kTextFieldComponentHeightConstraint = CGFloat(0)
    fileprivate let kTextFieldComponentDefaultMultiplierConstraint = CGFloat(1)
    
    private var textField: DynamicTextField!
    private var actionDelegate: DynamicActionDelegate?

}

extension TextFieldComponent: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.actionDelegate != nil {
            self.actionDelegate?.callAction(sender: self.textField.text ?? "")
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.actionDelegate != nil {
            self.actionDelegate?.callAction(sender: self.textField.text ?? "")
        }
    }
    
}
