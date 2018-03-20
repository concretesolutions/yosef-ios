//
//  FloatTypeConverter.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

public class FloatTypeConverter: ConcreteTypeConverter<CGFloat> {
    override func validateForType(value: Any) -> CGFloat? {
        if let stringValue = value as? String, let value = NumberFormatter().number(from: stringValue) {
            return CGFloat(truncating: value)
        }
        
        if let intValue = value as? Int {
            return CGFloat(intValue)
        }
        
        return super.validateForType(value: value)
    }
}
