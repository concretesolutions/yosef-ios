//
//  ScaleTypeTypeConverter.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

class ScaleTypeTypeConverter: TypedTypeConverter {
    
    typealias Model = UIView.ContentMode
    
    func validateForType(value: Any) -> UIView.ContentMode? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        if stringValue == "scaleToFill" {
            return UIView.ContentMode.scaleToFill
        } else if stringValue == "scaleAspectFit" {
            return UIView.ContentMode.scaleAspectFit
        } else if stringValue == "scaleAspectFill" {
            return UIView.ContentMode.scaleAspectFill
        }
        
        return nil
    }
}
