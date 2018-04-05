//
//  FontStyleTypeConverter.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

public class FontStyleTypeConverter: TypedTypeConverter {
    
    func validateForType(value: Any) -> [UIFontDescriptorSymbolicTraits]? {
        guard let stringValue = value as? String else {
            return nil
        }
        
        if stringValue == "bold" {
            return [UIFontDescriptorSymbolicTraits.traitBold]
        } else if stringValue == "italic" {
            return [UIFontDescriptorSymbolicTraits.traitItalic]
        } else if stringValue == "boldItalic" {
            return [UIFontDescriptorSymbolicTraits.traitBold, UIFontDescriptorSymbolicTraits.traitItalic]
        }
        
        return nil
    }
    
}
