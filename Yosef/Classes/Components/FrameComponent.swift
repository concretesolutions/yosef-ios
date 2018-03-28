//
//  FrameComponent.swift
//  Yosef
//
//  Created by kaique.pantosi on 21/03/18.
//

import UIKit

class FrameComponent: BaseComponent {
    
    fileprivate let kFrameComponentType = "frame"
    
    override func applyViewsFromJson(dynamicComponent: DynamicComponent,
                                     actionDelegate: DynamicActionDelegate) throws -> UIView {
        
        let view = try FrameComponentView(items: dynamicComponent.children ?? [], delegate: actionDelegate)
        return view
        
    }
}

private class FrameComponentView: UIView {
    
    var components: [DynamicComponent]
    var delegate: DynamicActionDelegate

    init(items: [DynamicComponent], delegate: DynamicActionDelegate) throws {
        self.components = items
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
        try setupChildren()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupChildren() throws {
        for component in components {
            let childView = try DynamicView.createView(dynamicsComponent: component, actionDelegate: delegate)
            self.addSubview(childView)
            
            let gravity = component.properties?.first(where: { $0.name == "gravity" })?.value as? Gravity ?? Gravity()
            
            childView.translatesAutoresizingMaskIntoConstraints = false
            
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
    }
}
