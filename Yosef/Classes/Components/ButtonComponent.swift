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
//    case action = "action"
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

extension UIButton {
    var text: String? {
        get {
            return self.title(for: .normal)
        }
        
        set {
            self.setTitle(newValue, for: .normal)
        }
    }
    
    var textColor: UIColor? {
        get {
            return self.titleColor(for: .normal)
        }
        set {
            self.setTitleColor(newValue, for: .normal)
        }
    }
}

class ButtonComponent: BaseComponent {
    
    private var propertyDictionary: [ButtonProperty: AnyPropertyApplier<UIButton>] =
        [.text: AnyPropertyApplier(KeyPathApplier(\UIButton.text)),
         .textColor: AnyPropertyApplier(KeyPathApplier(\UIButton.textColor)),
         .backgroundColor: AnyPropertyApplier(KeyPathApplier(\UIButton.backgroundColor)),
         .textSize: AnyPropertyApplier(FontSizeApplier<UIButton>())]
    
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
    
    override func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws {
        if dynamicComponent.type == kButtonComponentType {
            self.button = DynamicButton()
            self.button.titleEdgeInsets = UIEdgeInsetsMake(kButtonComponentTitleInsetTop, kButtonComponentTitleInsetLeft, kButtonComponentTitleInsetBottom, kButtonComponentTitleInsetRight)
            self.button.titleLabel?.numberOfLines = kButtonComponentNumberOfLines
            self.button.titleLabel?.adjustsFontSizeToFitWidth = true
            self.button.titleLabel?.lineBreakMode = .byClipping
            self.button.titleLabel?.baselineAdjustment = .alignCenters
            self.button.delegate = actionDelegate
            self.button.addTarget(self.button, action: #selector(DynamicButton.buttonTapped), for: .touchUpInside)
            self.buttonActionListener = actionDelegate
            self.setupDefaultProperties()
            try self.addProperties(properties: dynamicComponent.properties)
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
    
    private func addProperties(properties: [DynamicProperty]?) throws {
        try properties?.forEach({
            try self.identityAndApplyProperties(property: $0)
        })
    }
    
    private func identityAndApplyProperties(property: DynamicProperty) throws {
        guard let textViewProperty = ButtonProperty(rawValue: property.name),
            let applier = propertyDictionary[textViewProperty] else {
                throw ParseError.unknownProperty
        }
        
        _ = try applier.apply(value: property.value, to: button)
    }
}
