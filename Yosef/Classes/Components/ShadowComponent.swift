//
//  ShadowComponent.swift
//  Yosef
//
//  Created by kaique.pantosi on 04/05/18.
//

import Foundation

class ShadowComponent: PropertyBasedViewComponent {
    
    var propertyDictionary: [String : AnyPropertyApplier<UIView>] = [
        "margin": AnyPropertyApplier(EmptyApplier()),
        "colors": AnyPropertyApplier(GradientApplier())
    ]
    
    func createView(actionDelegate: DynamicActionDelegate) -> UIView {
        return GradientView()
    }
    
    fileprivate let kFrameComponentType = "shadow"
}
