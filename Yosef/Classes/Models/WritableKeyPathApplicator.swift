//
//  WritableKeyPathApplicator.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

class KeyPathApplier<ViewType: UIView, ValueType>: TypedPropertyApplier {
    
    private let keyPath: ReferenceWritableKeyPath<ViewType, ValueType>
    init(_ keyPath: ReferenceWritableKeyPath<ViewType, ValueType>) {
        self.keyPath = keyPath
    }
    
    func apply(value: Any, to view: ViewType) throws -> ViewType {
        if let value = value as? ValueType {
            view[keyPath: self.keyPath] = value
        } else {
            throw ParseError.invalidType
        }
        return view
    }
}
