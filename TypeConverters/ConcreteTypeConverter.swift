//
//  ConcreteTypeConverter.swift
//  iOSSnapshotTestCase
//
//  Created by kaique.pantosi on 19/03/18.
//

class ConcreteTypeConverter<T>: TypeConverter {
    func validate(value: Any) -> Any? {
        return value as? T
    }
}
