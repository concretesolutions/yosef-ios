//
//  aspectRatioTypeConverter.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

struct aspectRatio {
    var height: Float
    var width: Float
    
    init?(height: Float, width: Float) {
        guard height > 0 && width > 0 else {
            return nil
        }
        
        self.height = height
        self.width = width
    }
    
    var radio: Float {
        return self.height / self.width
    }
}

class aspectRatioTypeConverter: TypedTypeConverter {
    
    func validateForType(value: Any) -> aspectRatio? {
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
        
        let heightString = valuesArray[0]
        let widthString = valuesArray[1]
        
        return aspectRatio(height: heightString.floatValue, width: widthString.floatValue)
    }
}
