//
//  SelfConstraintApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 19/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

enum Dimension {
    case width
    case height
}

class SelfConstraintApplier<V: UIView>: TypedPropertyApplier {
    
    typealias ViewType = V
    
    let dimension: Dimension
    
    init(dimension: Dimension) {
       self.dimension = dimension
    }
    
    func apply(value: CGFloat, to view: V) throws -> V {
        switch self.dimension {
        case .width:
            view.widthAnchor.constraint(equalToConstant: value).isActive = true
        case .height:
            view.heightAnchor.constraint(equalToConstant: value).isActive = true
        }
        
        return view
    }
}
