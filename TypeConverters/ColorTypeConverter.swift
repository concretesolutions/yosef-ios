//
//  ColorTypeConverter.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

class ColorTypeConverter: TypeConverter {
    
    func validate(value: Any) -> Any? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        return UIColor(hexadecimalString: stringValue)
    }
}
