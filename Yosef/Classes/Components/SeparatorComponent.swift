//
//  SeparatorComponent.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

class SeparatorComponent: PropertyBasedViewComponent {
    
    var propertyDictionary: [String : AnyPropertyApplier<UIView>] = [
        "backgroundColor": AnyPropertyApplier(KeyPathApplier(\UIView.backgroundColor)),
        "margin": AnyPropertyApplier(EmptyApplier()),
        "height": AnyPropertyApplier(SelfConstraintApplier(dimension: .height)),
        "width": AnyPropertyApplier(EmptyApplier())
    ]
    
    func createView() -> UIView {
        return UIView()
    }
    
    fileprivate let kFrameComponentType = "separator"
    
}
