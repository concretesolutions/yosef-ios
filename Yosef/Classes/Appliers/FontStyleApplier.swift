//
//  FontStyleApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 22/03/18.
//

import Foundation

public class FontStyleApplier<TextViewComponent: TextComponent>: TypedPropertyApplier {
    
    typealias ViewType = TextViewComponent
    
    func apply(value: UIFont.Weight, to view: TextViewComponent) throws -> TextViewComponent {
        let currentFont = view._font ?? UIFont.systemFont(ofSize: 14.0)
        
        var descriptor = currentFont.fontDescriptor.fontAttributes
        var attributes = (descriptor[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        attributes[.weight] = value
        
        descriptor[.traits] = attributes
        
        let fontDescriptor = UIFontDescriptor(fontAttributes: descriptor)
        
        view._font = UIFont(descriptor: fontDescriptor, size: currentFont.pointSize)
        
        return view
    }
}
