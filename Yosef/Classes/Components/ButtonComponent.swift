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
            delegate?.callAction(event: action)
        }
    }
}

class ButtonComponent: PropertyBasedViewComponent {
    
    typealias View = DynamicButton
    
    func createView(actionDelegate: DynamicActionDelegate) -> DynamicButton {
        let button = DynamicButton()
        button.titleEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byClipping
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.delegate = actionDelegate
        button.addTarget(self.button, action: #selector(DynamicButton.buttonTapped), for: .touchUpInside)
        
        self.setupDefaultProperties(on: button)

        return button
    }
        
    var propertyDictionary: [String: AnyPropertyApplier<DynamicButton>] =
        ["text": AnyPropertyApplier(KeyPathApplier(\DynamicButton.text)),
         "textColor": AnyPropertyApplier(KeyPathApplier(\DynamicButton.textColor)),
         "backgroundColor": AnyPropertyApplier(KeyPathApplier(\DynamicButton.backgroundColor)),
         "textSize": AnyPropertyApplier(FontSizeApplier<DynamicButton>()),
         "action": AnyPropertyApplier(KeyPathApplier(\DynamicButton.action))]
    
    fileprivate var button: DynamicButton!
    fileprivate var buttonActionListener: DynamicActionDelegate!
    
    
    private func setupDefaultProperties(on button: DynamicButton){
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
    }
}
