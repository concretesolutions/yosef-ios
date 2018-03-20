//
//  ConcreteTypeConverter.swift
//  iOSSnapshotTestCase
//
//  Created by kaique.pantosi on 19/03/18.
//

class ConcreteTypeConverter<T>: TypedTypeConverter {
    typealias Model = T
    
    func validateForType(value: Any) -> T? {
        return value as? T
    }
}
