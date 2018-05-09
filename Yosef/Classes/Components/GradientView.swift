//
//  GradientView.swift
//  Yosef
//
//  Created by kaique.pantosi on 04/05/18.
//

import UIKit

class GradientView: UIView {
    
    var colors = [CGColor]()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        
        return gradientLayer
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.layer.addSublayer(gradientLayer)
    }
}
