//
//  URLTypeConverter.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

class URLTypeConverter: TypeConverter {
    
    func validate(value: Any) -> Any? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        return URL(string: stringValue)
    }
}
