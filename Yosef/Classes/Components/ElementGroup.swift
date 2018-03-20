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
    
    override func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) {
        if dynamicComponent.type == kElementGroupComponentType {
            self.stackView = UIStackView()
            
            self.addProperties(properties: dynamicComponent.properties)
            setUpStackView(view)
            addChild(dynamicComponent.children ?? [], view: view, action: actionDelegate)
        }
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
    private func setUpStackView(_ view: UIView) {
        setUpConstraints(view)
        
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
    
    private func setUpConstraints(_ view: UIView) {
        view.addSubview(self.stackView)
        self.stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

// MARK: - Add Child elements

extension ElementGroupComponent {
    private func addChild(_ childs: [DynamicComponent], view: UIView, action: DynamicActionDelegate) {
        for child in childs {
            let childView = DynamicView.createView(dynamicsComponent: child, actionDelegate: action)
            self.stackView.addArrangedSubview(childView)
        }
    }
}
