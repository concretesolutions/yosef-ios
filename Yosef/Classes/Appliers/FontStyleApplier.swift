//
//  FontStyleApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 22/03/18.
//

import Foundation

public class FontStyleApplier<TextViewComponent: TextComponent>: TypedPropertyApplier {
    
    typealias ViewType = TextViewComponent
    func apply(value: [UIFontDescriptorSymbolicTraits], to view: TextViewComponent) throws -> TextViewComponent {
        let currentFont = view._font ?? UIFont.systemFont(ofSize: 14.0)
        
        var traits = currentFont.fontDescriptor.symbolicTraits
        value.forEach { traits.insert($0) }
        
        guard let fontDescriptor = currentFont.fontDescriptor.withSymbolicTraits(traits) else {
            return view
        }
        
        view._font = UIFont(descriptor: fontDescriptor, size: currentFont.pointSize)
        
        return view
    }
}

