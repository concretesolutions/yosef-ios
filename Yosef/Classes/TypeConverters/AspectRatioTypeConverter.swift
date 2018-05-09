//
//  aspectRatioTypeConverter.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

struct AspectRatio {
    var width: Float
    var height: Float
    
    init?(width: Float, height: Float) {
        guard height > 0 && width > 0 else {
            return nil
        }
        
        self.width = width
        self.height = height
    }
    
    var radio: Float {
        return self.height / self.width
    }
}

class AspectRatioTypeConverter: TypedTypeConverter {
    
    func validateForType(value: Any) -> AspectRatio? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        let numberFormater = NumberFormatter()
        #if swift(>=4.1)
        let valuesArray = stringValue.split(separator: ":").compactMap {
            return numberFormater.number(from: String($0))
        }
        #else
        let valuesArray = stringValue.split(separator: ":").flatMap {
            return numberFormater.number(from: String($0))
        }
        #endif
        
        guard valuesArray.count == 2 else {
            return nil
        }
        
        let widthString = valuesArray[0]
        let heightString = valuesArray[1]
        
        return AspectRatio(width: widthString.floatValue, height: heightString.floatValue)
    }
}
