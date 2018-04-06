//
//  ElementGroup.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

fileprivate enum ElementGroupProperty: String {
    case orientation = "orientation"
}

fileprivate enum ElementGroupOrientation: String {
    case horizontal = "horizontal"
    case vertical   = "vertical"
}

class ElementGroupComponent: ViewComponent {
    
    fileprivate let kElementGroupComponentType = "elementGroup"
    fileprivate var orientation = ElementGroupOrientation.vertical
    fileprivate var stackView: UIStackView!
    
    func createViewFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView {
        
            let stackView = UIStackView()
            
            self.addProperties(properties: dynamicComponent.properties, on: stackView)
            setUp(stackView: stackView)
            addChild(dynamicComponent.children, action: actionDelegate, on: stackView)
        return stackView
        
    }
}

// MARK: - Setup Properties

extension ElementGroupComponent {
    private func addProperties(properties: [DynamicProperty]?, on view: UIStackView) {
        if let properties = properties {
            for item in properties {
                self.identityAndApplyProperties(property: item, on: view)
            }
        }
    }
    
    private func identityAndApplyProperties(property: DynamicProperty, on view: UIStackView) {
        if let propertyValue = property.value as? String, let elementGroupProperty = ElementGroupProperty(rawValue: property.name) {
            switch elementGroupProperty {
            case .orientation:
                if let ori = ElementGroupOrientation(rawValue: propertyValue) {
                    self.orientation = ori
                }
                break
            }
        }
    }
}

// MARK: - Setup Stack View

extension ElementGroupComponent {
    private func setUp(stackView: UIStackView) {
        
        switch self.orientation {
        case .horizontal:
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            break
        case .vertical:
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            break
        }
        
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Add Child elements

extension ElementGroupComponent {
    private func addChild(_ childs: [DynamicComponent], action: DynamicActionDelegate, on stackView: UIStackView) {
        for child in childs {
            let view = try! DynamicView.createView(dynamicsComponent: child, actionDelegate: action)
            let marginView = UIView()
            
            marginView.translatesAutoresizingMaskIntoConstraints = false
            view.translatesAutoresizingMaskIntoConstraints = false
            marginView.addSubview(view)
            
            let marginApplier = MarginApplier()
            marginApplier.tryApplyMargin(component: child, to: view, in: marginView)
            
            stackView.addArrangedSubview(marginView)
        }
    }
}
