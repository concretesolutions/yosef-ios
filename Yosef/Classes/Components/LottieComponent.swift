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

class LottieComponent: ViewComponent {
    
    fileprivate var lottieView: LOTAnimationView!
    
    func createViewFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView {
    
            self.addProperties(dynamicComponent.properties)
            self.setUpAnimation()
        
            return self.lottieView
        
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
    private func setUpAnimation() {
        //        lottieView.contentMode = .scaleAspectFit
        //        lottieView.animationSpeed = 1.0
        lottieView.loopAnimation = true
        lottieView.play()
    }
}

// MARK: - JSON

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
