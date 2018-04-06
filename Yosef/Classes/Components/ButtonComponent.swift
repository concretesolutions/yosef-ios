//
//  ButtonComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

public class DynamicButton: UIButton {
    var action: String?
    
    weak var delegate: DynamicActionDelegate?
    
    @objc func buttonTapped() {
        if let action = action {
            delegate?.callAction(sender: action)
        }
    }
}

class ButtonComponent: PropertyBasedViewComponent {
    
    typealias View = UIButton
    
    func createView() -> UIButton {
        let button = DynamicButton()
        button.titleEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8)
        button.titleLabel?.numberOfLines = 0
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
    
    fileprivate var button: DynamicButton!
    fileprivate var buttonActionListener: DynamicActionDelegate!
    
    
    private func setupDefaultProperties(on button: DynamicButton){
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
    }
}
