//
//  AspectRadioTypeConverter.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

struct AspectRadio {
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

class AspectRadioTypeConverter: TypedTypeConverter {
    
    func validateForType(value: Any) -> AspectRadio? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        let numberFormater = NumberFormatter()
        let valuesArray = stringValue.split(separator: ":").compactMap {
            return numberFormater.number(from: String($0))
        }
        
        guard valuesArray.count == 2 else {
            return nil
        }
        
        let heightString = valuesArray[0]
        let widthString = valuesArray[1]
        
        return AspectRadio(height: heightString.floatValue, width: widthString.floatValue)
    }
}
