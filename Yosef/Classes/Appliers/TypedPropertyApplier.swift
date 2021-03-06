//
//  TypedPropertyApplier.swift
//  Yosef
//
//  Created by Bruno Mazzo on 19/03/2018.
//  Copyright © 2018 Concrete. All rights reserved.
//

protocol TypedPropertyApplier: PropertyApplier {
    associatedtype Model
    
    func apply(value: Model, to: ViewType) throws -> ViewType
}

extension TypedPropertyApplier {
    func apply(value: Any, to view: ViewType) throws -> ViewType {
        guard let model = value as? Model else {
            throw ParseError.invalidTypeValue(String(describing: type(of: value)))
        }
        
        return try self.apply(value: model, to: view)
    }
}
