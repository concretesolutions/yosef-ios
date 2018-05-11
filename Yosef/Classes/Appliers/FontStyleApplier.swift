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
        
        view._font = UIFont.systemFont(ofSize: currentFont.pointSize, weight: value)
        
        return view
    }
}

