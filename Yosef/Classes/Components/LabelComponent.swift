//
//  LabelComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

fileprivate enum LabelViewProperty: String {
    case text = "text"
    case textColor = "textColor"
    case backgroundColor = "backgroundColor"
    case textSize = "textSize"
}

class LabelComponent: BaseComponent {

    fileprivate let kLabelComponentType = "text"
    fileprivate let kLabelComponentTitleInsetTop = CGFloat(4)
    fileprivate let kLabelComponentTitleInsetBottom = CGFloat(4)
    fileprivate let kLabelComponentTitleInsetLeft = CGFloat(8)
    fileprivate let kLabelComponentTitleInsetRight = CGFloat(8)
    fileprivate let kLabelComponentNumberOfLines = 5
    fileprivate let kLabelComponentLeadingConstraint = CGFloat(16)
    fileprivate let kButtonComponentTrailingConstraint = CGFloat(-16)
    fileprivate let kLabelComponentTopConstraint = CGFloat(0)
    fileprivate let kLabelComponentHeightConstraint = CGFloat(0)
    fileprivate let kLabelComponentDefaultMultiplierConstraint = CGFloat(1)
    
    fileprivate var label: UILabel!
    
    override func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) {
        if dynamicComponent.type == kLabelComponentType {
            self.label = UILabel()
            self.addProperties(properties: dynamicComponent.properties)
            view.addSubview(self.label)
            self.setupConstraints(view: view)
        }
    }
    
    // MARK: Setup Properties
    
    private func setupConstraints(view: UIView) {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.setContentHuggingPriority(.required, for: .vertical)
        self.label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: kLabelComponentTitleInsetTop).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: kLabelComponentTitleInsetBottom).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kLabelComponentTitleInsetLeft).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: kLabelComponentTitleInsetRight).isActive = true
    }
    
    private func addProperties(properties: [DynamicProperty]?) {
        if let properties = properties {
            for item in properties {
                self.identityAndApplyProperties(property: item)
            }
        }
    }
    
    private func identityAndApplyProperties(property: DynamicProperty) {
        if let propertyName = property.name, let textViewProperty = LabelViewProperty(rawValue: propertyName) {
            switch textViewProperty {
            case .text:
                self.setLabelText(text: property.value)
                break
            case .textColor:
                self.setLabelTextColor(textColorString: property.value)
                break
            case .backgroundColor:
                self.setLabelBackgroundColor(colorString: property.value)
                break
            case .textSize:
                self.setLabelTextSize(textSize: property.value)
                break
            }
        }
    }
    
    private func setLabelText(text: String?) {
        label.text = text
        label.numberOfLines = kLabelComponentNumberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.baselineAdjustment = .alignCenters
    }
    
    private func setLabelTextColor(textColorString: String?) {
        if let color = textColorString {
            label.textColor = UIColor.init(hexadecimalString:color)
        }
    }
    
    private func setLabelBackgroundColor(colorString: String?) {
        if let color = colorString {
            label.backgroundColor = UIColor.init(hexadecimalString:color)
        }
    }
    
    private func setLabelTextSize(textSize: String?) {
        if let sizeString = textSize, let sizeValue = Float(sizeString) {
            let fontSize = CGFloat(sizeValue)
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
