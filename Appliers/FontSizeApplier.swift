//
//  FontSizeApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
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

class FontSizeApplier<TextViewType: UIView>: TypedPropertyApplier {

    typealias ViewType = TextViewType
    
    func apply(value: CGFloat, to view: TextViewType) throws -> TextViewType {
        guard let textComponent = view as? TextComponent else {
            throw ParseError.invalidType
        }
        textComponent._font = UIFont.systemFont(ofSize: value)

        return view
    }
}
