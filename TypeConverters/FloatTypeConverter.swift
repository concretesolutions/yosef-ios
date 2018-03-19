//
//  DimensionTypeConverter.swift
//  iOSSnapshotTestCase
//
//  Created by kaique.pantosi on 19/03/18.
//

import Foundation

class FloatTypeConverter: ConcreteTypeConverter<CGFloat> {
    override func validate(value: Any) -> Any? {
        if let stringValue = value as? String, let value = NumberFormatter().number(from: stringValue) {
            return value
        }
        
        if let intValue = value as? Int {
            return CGFloat(intValue)
        }
        
        return super.validate(value: value) as? Float
    }
}
