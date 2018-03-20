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

fileprivate enum TextFieldProperty: String {
    case text = "text"
    case textColor = "textColor"
//    case action = "action"
    case placeholder = "placeholder"
}

class TextFieldComponent: BaseComponent {
    
    private var propertyDictionary: [TextFieldProperty: AnyPropertyApplier<UITextField>] =
        [.text: AnyPropertyApplier(KeyPathApplier(\UITextField.text)),
         .textColor: AnyPropertyApplier(KeyPathApplier(\UITextField.textColor)),
         .placeholder: AnyPropertyApplier(KeyPathApplier(\UITextField.placeholder))]
    
    fileprivate let kTextFieldComponentType = "textField"
    fileprivate let kTextFieldComponentLeadingConstraint = CGFloat(16)
    fileprivate let kTextFieldComponentTrailingConstraint = CGFloat(-16)
    fileprivate let kTextFieldComponentTopConstraint = CGFloat(50)
    fileprivate let kTextFieldComponentHeightConstraint = CGFloat(0)
    fileprivate let kTextFieldComponentDefaultMultiplierConstraint = CGFloat(1)
    
    private var textField: DynamicTextField!
    private var actionDelegate: DynamicActionDelegate?
    
    override func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws {
        if dynamicComponent.type == kTextFieldComponentType {
            self.textField = DynamicTextField()
            self.textField.delegate = self
            self.textField.returnKeyType = .done
            self.actionDelegate = actionDelegate
            try self.addProperties(properties: dynamicComponent.properties)
            view.addSubview(self.textField)
            self.setupConstraints(view: view)
        }
    }
    
    // MARK: Setup Properties
    
    private func setupConstraints(view: UIView) {
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.setContentHuggingPriority(.required, for: .vertical)
        self.textField.setContentCompressionResistancePriority(.required, for: .vertical)
        
        view.addConstraint(NSLayoutConstraint(item: self.textField, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: kTextFieldComponentDefaultMultiplierConstraint, constant: kTextFieldComponentTopConstraint))
        view.addConstraint(NSLayoutConstraint(item: self.textField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: kTextFieldComponentDefaultMultiplierConstraint, constant: kTextFieldComponentLeadingConstraint))
        view.addConstraint(NSLayoutConstraint(item: self.textField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: kTextFieldComponentDefaultMultiplierConstraint, constant: kTextFieldComponentTrailingConstraint))
        view.addConstraint(NSLayoutConstraint(item: self.textField, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: kTextFieldComponentDefaultMultiplierConstraint, constant: kTextFieldComponentHeightConstraint))
    }
    
    private func addProperties(properties: [DynamicProperty]?) throws {
        try properties?.forEach({
            try self.identityAndApplyProperties(property: $0)
        })
    }
    
    private func identityAndApplyProperties(property: DynamicProperty) throws {
        guard let textFieldProperty = TextFieldProperty(rawValue: property.name),
            let applier = propertyDictionary[textFieldProperty] else {
                throw ParseError.unknownProperty
        }
        
        _ = try applier.apply(value: property.value, to: textField)
    }
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
