//
//  ScaleTypeTypeConverter.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

class ScaleTypeTypeConverter: TypedTypeConverter {
    
    typealias Model = UIViewContentMode
    
    func validateForType(value: Any) -> UIViewContentMode? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        if stringValue == "scaleToFill" {
            return UIViewContentMode.scaleToFill
        } else if stringValue == "scaleAspectFit" {
            return UIViewContentMode.scaleAspectFit
        } else if stringValue == "scaleAspectFill" {
            return UIViewContentMode.scaleAspectFill
        }
        
        return nil
    }
}
