//
//  GradientApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 04/05/18.
//

import Foundation
import UIKit

import Foundation

class GradientApplier<ViewType: UIView>: TypedPropertyApplier {
    
    func apply(value: [CGColor], to: ViewType) throws -> ViewType {
        
        if let gradientView = to as? GradientView {
            gradientView.colors = value
        }

        return to
    }
}
