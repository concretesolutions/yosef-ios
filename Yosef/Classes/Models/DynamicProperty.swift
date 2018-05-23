//
//  DynamicProperty.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

public class DynamicProperty: NSObject {
    
    static var typeConverters: [String: TypeConverter] = ["dimen" : FloatTypeConverter(),
                                                          "string" : ConcreteTypeConverter<String>(),
                                                          "color" : ColorTypeConverter(),
                                                          "colors": ColorsTypeConverter(),
                                                          "url" : URLTypeConverter(),
                                                          "fontWeight": FontWeightTypeConverter(),
                                                          "gravity": GravityTypeConverter(),
                                                          "fontStyle": FontStyleTypeConverter(),
                                                          "margin": MarginTypeConverter(),
                                                          "scaleType": ScaleTypeTypeConverter(),
                                                          "aspectRatio": AspectRatioTypeConverter(),
                                                          "dimenSpec": DimenSpecTypeConverter(),
                                                          "corner": CornerTypeConverter()]
    
    // MARK: Constants
    
    fileprivate static let kName = "name"
    fileprivate static let kType = "type"
    fileprivate static let kValue = "value"
    
    // MARK: Properties
    
    var name: String
    var type: String
    var value: Any
    
    // MARK: Initializers
    
    init(dictionary: [String: Any]) throws {
        guard let name = dictionary[DynamicProperty.kName] as? String,
            let type = dictionary[DynamicProperty.kType] as? String,
            let value = dictionary[DynamicProperty.kValue] as? String else {
                throw DynamicPropertyError.invalidJSONFormat
        }
        
        guard let typeConverter = DynamicProperty.typeConverters[type] else {
            throw DynamicPropertyError.unknownType(type: type)
        }
        
        guard let convertedValue = typeConverter.validate(value: value) else {
            throw DynamicPropertyError.invalidValue(type: type, value: value)
        }
        
        self.name = name
        self.type = type
        self.value = convertedValue
    }
}

extension DynamicProperty {
    
    public override var debugDescription: String {
        let name = self.name
        let type = self.type
        let value = self.value
        return "DynamicProperty:\n\tname: \(name)\n\ttype: \(type)\n\tvalue: \(value)"
    }
    
}
