//
//  LottieComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import Lottie

fileprivate enum LottieProperty: String {
    case value = "animate"
}

class LottieComponent: BaseComponent {
    
    fileprivate let kLottieComponentType = "animation"
    
    fileprivate var lottieView: LOTAnimationView!
    
    override func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) {
        if dynamicComponent.type == kLottieComponentType {
            self.addProperties(dynamicComponent.properties)
            self.setUpAnimation(view)
            view.addSubview(lottieView)
            setUpConstraints(view)
        }
    }
}

// MARK: - Properties

extension LottieComponent {
    private func addProperties(_ properties: [DynamicProperty]?) {
        if let properties = properties {
            for property in properties {
                self.identifyAndApplyProperty(property)
            }
        }
    }
    
    private func identifyAndApplyProperty(_ property: DynamicProperty) {
        if let propertyValue = property.value as? String, let lottieProperty = LottieProperty(rawValue: property.name) {
            switch lottieProperty {
            case .value:
                setAnimationValue(propertyValue)
                break
            }
        }
    }
    
    private func setAnimationValue(_ value: String?) {
        if let jsonString = value {
            if let jsonObject = jsonString.toJSON() as? [AnyHashable:Any] {
                self.lottieView = LOTAnimationView(json: jsonObject)
            }
        }
    }
}

// MARK: - Animation

extension LottieComponent {
    private func setUpAnimation(_ view: UIView) {
        //        lottieView.contentMode = .scaleAspectFit
        //        lottieView.animationSpeed = 1.0
        lottieView.loopAnimation = true
        lottieView.play()
    }
}

// MARK: - Constraints

extension LottieComponent {
    private func setUpConstraints(_ view: UIView) {
        lottieView
            .centerXAnchor(equalTo: view.centerXAnchor)
            .centerYAnchor(equalTo: view.centerYAnchor)
            .heightAnchor(equalTo: 200)
            .widthAnchor(equalTo: 200)
    }
}

// MARK: - JSON

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
