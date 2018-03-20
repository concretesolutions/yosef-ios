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

class _BaseTypeConverter<Model>: TypedTypeConverter {
    
    func validateForType(value: Any) -> Model? {
        fatalError("Should Override Method")
    }
}

class _AnyTypeConverter<Concrete: TypedTypeConverter>: _BaseTypeConverter<Concrete.Model> {
    let concrete: Concrete
    
    init(_ concrete: Concrete) {
        self.concrete = concrete
    }
    
    override func validateForType(value: Any) -> Concrete.Model? {
        return self.concrete.validateForType(value: value)
    }
}

struct AnyTypeConverter<Model>: TypedTypeConverter {
    
    private let concrete: _BaseTypeConverter<Model>
    
    init<Concrete: TypedTypeConverter>(_ concrete: Concrete) where Concrete.Model == Model {
        self.concrete = _AnyTypeConverter(concrete)
    }
    
    func validateForType(value: Any) -> Model? {
        return self.concrete.validateForType(value: value)
    }
}
