//
//  ButtonComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

fileprivate enum ButtonProperty: String {
    case text = "text"
    case textColor = "textColor"
    case action = "action"
    case backgroundColor = "backgroundColor"
    case textSize = "textSize"
}

public class DynamicButton: UIButton {
    var action: String?
    
    weak var delegate: DynamicActionDelegate?
    
    @objc func buttonTapped() {
        if let action = action {
            delegate?.callAction(sender: action)
        }
    }
}

class ButtonComponent: BaseComponent {
    
    fileprivate let kButtonComponentType = "button"
    fileprivate let kButtonComponentTitleInsetTop = CGFloat(4)
    fileprivate let kButtonComponentTitleInsetBottom = CGFloat(4)
    fileprivate let kButtonComponentTitleInsetLeft = CGFloat(8)
    fileprivate let kButtonComponentTitleInsetRight = CGFloat(8)
    fileprivate let kButtonComponentNumberOfLines = 0
    fileprivate let kButtonComponentLeadingConstraint = CGFloat(16)
    fileprivate let kButtonComponentTrailingConstraint = CGFloat(-16)
    fileprivate let kButtonComponentTopConstraint = CGFloat(0)
    fileprivate let kButtonComponentHeightConstraint = CGFloat(0)
    fileprivate let kButtonComponentDefaultMultiplierConstraint = CGFloat(1)
    fileprivate let kButtonComponentDefaultCornerRadius = CGFloat(5)
    fileprivate let kButtonComponentDefaultBorderWidth = CGFloat(1)
    
    fileprivate var button: DynamicButton!
    fileprivate var buttonActionListener: DynamicActionDelegate!
    
    override func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) {
        if dynamicComponent.type == kButtonComponentType {
            self.button = DynamicButton()
            self.button.delegate = actionDelegate
            self.button.addTarget(self.button, action: #selector(DynamicButton.buttonTapped), for: .touchUpInside)
            self.buttonActionListener = actionDelegate
            self.setupDefaultProperties()
            self.addProperties(properties: dynamicComponent.properties)
            view.addSubview(button)
            self.setupConstraints(view: view)
        }
    }
    
    private func setupDefaultProperties(){
        self.button.layer.cornerRadius = kButtonComponentDefaultCornerRadius
        self.button.layer.borderWidth = kButtonComponentDefaultBorderWidth
        self.button.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setupConstraints(view: UIView) {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.setContentHuggingPriority(.required, for: .vertical)
        self.button.setContentCompressionResistancePriority(.required, for: .vertical)
        
        view.addConstraint(NSLayoutConstraint(item: self.button, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: kButtonComponentDefaultMultiplierConstraint, constant: kButtonComponentTopConstraint))
        view.addConstraint(NSLayoutConstraint(item: self.button, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: kButtonComponentDefaultMultiplierConstraint, constant: kButtonComponentLeadingConstraint))
        view.addConstraint(NSLayoutConstraint(item: self.button, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: kButtonComponentDefaultMultiplierConstraint, constant: kButtonComponentTrailingConstraint))
        view.addConstraint(NSLayoutConstraint(item: self.button, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: kButtonComponentDefaultMultiplierConstraint, constant: kButtonComponentHeightConstraint))
    }
    
    private func addProperties(properties: [DynamicProperty]?) {
        if let properties = properties {
            for item in properties {
                self.identityAndApplyProperties(property: item)
            }
        }
    }
    
    private func identityAndApplyProperties(property: DynamicProperty) {
        if let propertyName = property.name, let buttonProperty = ButtonProperty(rawValue: propertyName) {
            switch buttonProperty {
            case .text:
                self.setButtonTitle(title: property.value)
                break
            case .action:
                self.setButtonAction(action: property.value)
                break
            case .backgroundColor:
                self.setButtonBackgroundColor(colorString: property.value)
                break
            case .textColor:
                self.setButtonTextColor(textColorString: property.value)
                break
            case .textSize:
                self.setButtonTextSize(textSize: property.value)
                break
            }
        }
    }
    
    private func setButtonTitle(title: String?) {
        button.titleEdgeInsets = UIEdgeInsetsMake(kButtonComponentTitleInsetTop, kButtonComponentTitleInsetLeft, kButtonComponentTitleInsetBottom, kButtonComponentTitleInsetRight)
        button.setTitle(title, for: .normal)
        button.titleLabel?.numberOfLines = kButtonComponentNumberOfLines
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleLabel?.baselineAdjustment = .alignCenters
    }
    
    private func setButtonAction(action: String?) {
        self.button.action = action
    }
    
    private func setButtonTextColor(textColorString: String?) {
        if let color = textColorString {
            button.setTitleColor(UIColor.init(hexadecimalString:color), for: .normal)
        }
    }
    
    private func setButtonBackgroundColor(colorString: String?) {
        if let color = colorString {
            button.backgroundColor = UIColor.init(hexadecimalString:color)
        }
    }
    
    private func setButtonTextSize(textSize: String?) {
        if let sizeString = textSize, let sizeValue = Float(sizeString) {
            let fonteSize = CGFloat(sizeValue)
            button.titleLabel?.font = UIFont.systemFont(ofSize: fonteSize)
        }
    }
}
