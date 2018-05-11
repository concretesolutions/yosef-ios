//
//  FontStyleTypeConverter.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

public class FontStyleTypeConverter: TypedTypeConverter {
    
    func validateForType(value: Any) -> UIFont.Weight? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        if stringValue == "bold" {
            return .bold
        }
        
        return .regular
    }
    
}
