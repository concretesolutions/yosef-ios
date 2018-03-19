//
//  ColorTypeConverter.swift
//  iOSSnapshotTestCase
//
//  Created by kaique.pantosi on 19/03/18.
//

class ColorTypeConverter: TypeConverter {
    
    func validate(value: Any) -> Any? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        return UIColor(hexadecimalString: stringValue)
    }
}
