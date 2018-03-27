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

class ElementGroupComponent: BaseComponent {
    
    fileprivate let kElementGroupComponentType = "elementGroup"
    fileprivate var orientation = ElementGroupOrientation.vertical
    fileprivate var stackView: UIStackView!
    
    override func applyViewsFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView {
        
            self.stackView = UIStackView()
            
            self.addProperties(properties: dynamicComponent.properties)
            setUpStackView()
            addChild(dynamicComponent.children ?? [], action: actionDelegate)
        return self.stackView
        
    }
}

// MARK: - Setup Properties

extension ElementGroupComponent {
    private func addProperties(properties: [DynamicProperty]?) {
        if let properties = properties {
            for item in properties {
                self.identityAndApplyProperties(property: item)
            }
        }
    }
    
    private func identityAndApplyProperties(property: DynamicProperty) {
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
    private func setUpStackView() {
        
        switch self.orientation {
        case .horizontal:
            self.stackView.axis = .horizontal
            self.stackView.distribution = .fillEqually
            break
        case .vertical:
            self.stackView.axis = .vertical
            self.stackView.distribution = .equalSpacing
            break
        }
        
        self.stackView.alignment = .fill
        self.stackView.spacing = 16
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Add Child elements

extension ElementGroupComponent {
    private func addChild(_ childs: [DynamicComponent], action: DynamicActionDelegate) {
        for child in childs {
            let view = try! DynamicView.createView(dynamicsComponent: child, actionDelegate: action)
            let marginView = UIView()
            
            marginView.translatesAutoresizingMaskIntoConstraints = false
            view.translatesAutoresizingMaskIntoConstraints = false
            marginView.addSubview(view)
            
            let marginApplier = MarginApplier()
            marginApplier.tryApplyMargin(component: child, to: view, in: marginView)
            
            self.stackView.addArrangedSubview(marginView)
        }
    }
}
