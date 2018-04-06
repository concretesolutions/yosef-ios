//
//  TypeConverter.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

protocol TypeConverter {
    func validate(value: Any) -> Any?
}

protocol TypedTypeConverter: TypeConverter {
    associatedtype Model
    func validateForType(value: Any) -> Model?
}

extension TypedTypeConverter {
    func validate(value: Any) -> Any? {
        return self.validateForType(value: value)
    }
}
