//
//  SeparatorComponent.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

class SeparatorComponent: PropertyBasedViewComponent {
    
    var propertyDictionary: [String : AnyPropertyApplier<UIView>] = [
        "backgroundColor": AnyPropertyApplier<UIView>(KeyPathApplier(\UIView.backgroundColor)),
        "margin": AnyPropertyApplier<UIView>(EmptyApplier()),
        "height": AnyPropertyApplier<UIView>(SelfConstraintApplier<UIView>(dimension: .height)),
        "width": AnyPropertyApplier<UIView>(EmptyApplier())
    ]
    
    func createView() -> UIView {
        return UIView()
    }
    
    fileprivate let kFrameComponentType = "separator"
    
}
