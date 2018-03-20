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
        guard let value = value as? Model else {
            throw ParseError.invalidType
        }
        
        return try self.apply(value: value, to: view)
    }
}
