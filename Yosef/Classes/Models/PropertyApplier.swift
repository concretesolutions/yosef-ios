//
//  PropertyApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

public protocol View: class { }
extension UIView: View { }

protocol PropertyApplier {
    associatedtype ViewType: View
    
    func apply(value: Any, to: ViewType) throws -> ViewType
}

class _BasePropertyApplier<ViewType: View>: PropertyApplier  {
    func apply(value: Any, to: ViewType) throws -> ViewType {
        fatalError("Must be override")
    }
}

class _AnyPropertyApplier<ConcretePropertyApplier: PropertyApplier>: _BasePropertyApplier<ConcretePropertyApplier.ViewType> {
    
    let concrete: ConcretePropertyApplier
    
    init(_ concrete: ConcretePropertyApplier) {
        self.concrete = concrete
    }
    
    override func apply(value: Any, to view: ConcretePropertyApplier.ViewType) throws -> ConcretePropertyApplier.ViewType {
        return try self.concrete.apply(value: value, to: view)
    }
}

struct AnyPropertyApplier<ViewType: UIView>: PropertyApplier {
    
    let concrete: _BasePropertyApplier<ViewType>
    
    init<Concrete: PropertyApplier>(_ concrete: Concrete) where Concrete.ViewType == ViewType {
        self.concrete = _AnyPropertyApplier(concrete)
    }
    
    func apply(value: Any, to view: ViewType) throws -> ViewType {
        return try self.concrete.apply(value: value, to: view)
    }
}

//class PropertyApplier<ViewType: UIView, PropertyType> {
//    func apply(value: Any, to: ViewType) throws -> ViewType {
//        if let value = value as? PropertyType {
//            _ = try self.apply(value: value, to: to)
//        } else {
//            throw ParseError.invalidType
//        }
//    }
//
//    func apply(value: PropertyType, to: ViewType) throws -> ViewType {
//        fatalError("")
//    }
//}

