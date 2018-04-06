//
//  PropertyBasedViewComponent.swift
//  Yosef
//
//  Created by Bruno Mazzo on 06/04/2018.
//

import Foundation

protocol PropertyBasedViewComponent: ViewComponent {
    associatedtype View: UIView
    var propertyDictionary: [String: AnyPropertyApplier<View>] { get }
    func createView(actionDelegate: DynamicActionDelegate) -> View
}

extension PropertyBasedViewComponent {
    func createViewFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView {
        let view = self.createView(actionDelegate: actionDelegate)
        
        try self.addProperties(properties: dynamicComponent.properties, to: view)
        
        return view
    }
    
    private func addProperties(properties: [DynamicProperty], to view: View) throws {
        try properties.forEach({
            try self.identityAndApplyProperties(property: $0, to: view)
        })
    }
    
    private func identityAndApplyProperties(property: DynamicProperty, to view: View) throws {
        guard let applier = self.propertyDictionary[property.name] else {
            throw ParseError.unknownProperty(property.name)
        }
        
        _ = try applier.apply(value: property.value, to: view)
    }
}
