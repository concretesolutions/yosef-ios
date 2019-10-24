//
//  ScaleTypeApplier.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

class ScaleTypeApplier<ViewType: UIView>: TypedPropertyApplier {
    
    func apply(value: UIView.ContentMode, to: ViewType) throws -> ViewType {
        to.contentMode = value
        return to
    }
}
