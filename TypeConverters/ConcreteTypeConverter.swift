//
//  ConcreteTypeConverter.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

class ConcreteTypeConverter<T>: TypedTypeConverter {
    typealias Model = T
    
    func validateForType(value: Any) -> T? {
        return value as? T
    }
}
