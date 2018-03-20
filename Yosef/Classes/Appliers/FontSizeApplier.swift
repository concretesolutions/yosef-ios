//
//  FontSizeApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

public protocol TextComponent: View {
    var _font: UIFont! {get set}
}

extension UILabel: TextComponent {
    public var _font: UIFont! {
        get {
            return self.font
        }
        set {
            self.font = newValue
        }
    }
}

extension UIButton: TextComponent {
    public var _font: UIFont! {
        get {
            return self.titleLabel?.font
        }
        
        set {
            self.titleLabel?.font = newValue
        }
    }
}

public class FontSizeApplier<TextViewComponent: TextComponent>: TypedPropertyApplier {
    
    typealias ViewType = TextViewComponent
    
    func apply(value: CGFloat, to view: TextViewComponent) throws -> TextViewComponent {
        view._font = UIFont.systemFont(ofSize: value)
        return view
    }
}
