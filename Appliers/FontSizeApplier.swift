//
//  FontSizeApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

class FontSizeApplier: PropertyApplier<UILabel, CGFloat> {
    
   override func apply(value: CGFloat, to: UILabel) throws -> UILabel {
        to.font = UIFont.systemFont(ofSize: floatValue)
        
        return to
    }
}
