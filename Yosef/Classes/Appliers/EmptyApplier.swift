//
//  EmptyApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 26/03/18.
//

import Foundation

class EmptyApplier<View: UIView>: TypedPropertyApplier {
    typealias ViewType = View
    typealias Model = Any
    
    func apply(value: Any, to: View) throws -> View { return to }
}
