//
//  FrameComponent.swift
//  Yosef
//
//  Created by kaique.pantosi on 21/03/18.
//

import UIKit

class FrameComponent: ViewComponent {
    
    func createViewFromJson(dynamicComponent: DynamicComponent,
                            actionDelegate: DynamicActionDelegate) throws -> UIView {
        
        let view = try FrameComponentView(items: dynamicComponent.children, delegate: actionDelegate, properties: dynamicComponent.properties)
        return view
    }
}

private class FrameComponentView: UIView {
    
    var components: [DynamicComponent]
    var delegate: DynamicActionDelegate
    var properties: [DynamicProperty]
    
    init(items: [DynamicComponent], delegate: DynamicActionDelegate, properties: [DynamicProperty]) throws {
        self.components = items
        self.delegate = delegate
        self.properties = properties
        super.init(frame: .zero)
        setupView()
        try setupChilds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var radius: CGFloat = 0
    
    private func setupChilds() throws {
        for component in components {
            let childView = try DynamicView.createView(dynamicsComponent: component, actionDelegate: delegate)
            self.addSubview(childView)
            childView.translatesAutoresizingMaskIntoConstraints = false
            
            for property in properties where property.name == "corner" {
                if let value = property.value as? Corners {
                    if let gradientView = childView as? GradientView {
                        gradientView.setCorners(corners: value)
                    } else {
                        rectCorners(from: value)
                        childView.layer.cornerRadius = radius
                    }
                }
            }
    
            if let gravity = component.properties.first(where: { $0.name == "gravity" })?.value as? Gravity {
                switch gravity.vertical {
                case .bottom:
                    childView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                    childView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
                case .top:
                    childView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
                    childView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                case .center:
                    childView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
                    childView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
                    childView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                }
                
                switch gravity.horizontal {
                case .left:
                    childView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                    childView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor).isActive = true
                case .right:
                    childView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor).isActive = true
                    childView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                case .center:
                    childView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                    childView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor).isActive = true
                    childView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor).isActive = true
                }
            }
            
            let marginApplier = MarginApplier()
            marginApplier.applyIfExistMargin(component: component, to: childView, in: self)
        }
    }
    
    private func rectCorners(from corners: Corners) {
        let tuple = (corners.topRight, corners.topLeft, corners.bottomRight, corners.bottomLeft)
        
        switch tuple {
        case let (tr, tl, bt, br):
            radius = tr
        default:
            radius = 0
        }
    }
}
