//
//  WritableKeyPathApplicator.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

class WritableKeyPathApplicator<ViewType: UIView>: PropertyApplier<ViewType> {
    
    private let applicator: (ViewType, Any) throws -> ViewType
    init<ValueType>(_ keyPath: WritableKeyPath<ViewType, ValueType>) {
        applicator = {
            var instance = $0
            if let value = $1 as? ValueType {
                instance[keyPath: keyPath] = value
            } else {
                throw ParseError.invalidType
            }
            return instance
        }
    }
    override func apply(value: Any, to: ViewType) throws -> ViewType {
        return try applicator(to, value)
    }
}
