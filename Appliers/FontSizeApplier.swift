//
//  FontSizeApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

class FontSizeApplier: PropertyApplier<UILabel> {
    
   override func apply(value: Any, to: UILabel) throws -> UILabel {
        guard let floatValue = value as? CGFloat else {
            throw ParseError.invalidType
        }
        
        to.font = UIFont.systemFont(ofSize: floatValue)
        
        return to
    }
}
