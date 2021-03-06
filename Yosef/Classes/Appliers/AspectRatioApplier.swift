//
//  AspectRatioApplier.swift
//  Yosef
//
//  Created by Bruno Mazzo on 05/04/2018.
//

import Foundation

class AspectRatioApplier<View: UIView>: TypedPropertyApplier {
    typealias ViewType = View
    
    func apply(value: AspectRatio, to view: View) throws -> View {
        view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(value.radio)).isActive = true
        return view
    }

}
