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

class ButtonComponent: PropertyBasedViewComponent {
    
    typealias View = UIButton
    
    func createView() -> UIButton {
        let button = DynamicButton()
        button.titleEdgeInsets = UIEdgeInsetsMake(kButtonComponentTitleInsetTop, kButtonComponentTitleInsetLeft, kButtonComponentTitleInsetBottom, kButtonComponentTitleInsetRight)
        button.titleLabel?.numberOfLines = kButtonComponentNumberOfLines
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleLabel?.baselineAdjustment = .alignCenters
//        self.button.delegate = actionDelegate
        button.addTarget(self.button, action: #selector(DynamicButton.buttonTapped), for: .touchUpInside)
//        self.buttonActionListener = actionDelegate
        self.setupDefaultProperties(on: button)
//        try self.addProperties(properties: dynamicComponent.properties)
        return button
    }
        
    var propertyDictionary: [String: AnyPropertyApplier<UIButton>] =
        ["text": AnyPropertyApplier(KeyPathApplier(\UIButton.text)),
         "textColor": AnyPropertyApplier(KeyPathApplier(\UIButton.textColor)),
         "backgroundColor": AnyPropertyApplier(KeyPathApplier(\UIButton.backgroundColor)),
         "textSize": AnyPropertyApplier(FontSizeApplier<UIButton>())]
    
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
    
    
    private func setupDefaultProperties(on button: DynamicButton){
        button.layer.cornerRadius = kButtonComponentDefaultCornerRadius
        button.layer.borderWidth = kButtonComponentDefaultBorderWidth
        button.layer.borderColor = UIColor.clear.cgColor
    }
}
