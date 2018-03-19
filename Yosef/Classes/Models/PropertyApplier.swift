//
//  PropertyApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//

class PropertyApplier<ViewType: UIView, PropertyType> {
    func apply(value: Any, to: ViewType) throws -> ViewType {
        if let value = value as? PropertyType {
            _ = try self.apply(value: value, to: to)
        } else {
            throw ParseError.invalidType
        }
    }
    
    func apply(value: PropertyType, to: ViewType) throws -> ViewType {
        fatalError("")
    }
}
