//
//  FontWeightTypeConverter.swift
//  Yosef
//
//  Created by kaique.pantosi on 26/03/18.
//

enum FontWeight: String {
    case bold
    case regular
    
    func getFontWeight() -> UIFont.Weight {
        switch self {
        case .bold:
            return UIFont.Weight.bold
        case .regular:
            return UIFont.Weight.regular
        }
    }
}

public class FontWeightTypeConverter: TypeConverter {
    
    func validate(value: Any) -> Any? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        return FontWeight(rawValue: stringValue)?.getFontWeight()
    }
}
