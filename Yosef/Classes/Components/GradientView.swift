//
//  GradientView.swift
//  Yosef
//
//  Created by kaique.pantosi on 04/05/18.
//

import UIKit

class GradientView: UIView {
    
    var colors = [CGColor]()
    var gradientLayer = CAGradientLayer()
    
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
        gradientLayer.colors = colors
        gradientLayer.frame = self.bounds
        roundCorners(corners, radius: Int(radius))
    }
    
    var corners: UIRectCorner = []
    var radius: CGFloat = 0
    
    func setCorners(corners: Corners) {
        gradientLayer.removeFromSuperlayer()
        rectCorners(from: corners)
        
        layoutIfNeeded()
    }
    
    private func rectCorners(from corners: Corners) {
        let tuple = (corners.topRight, corners.topLeft, corners.bottomRight, corners.bottomLeft)
        
        switch tuple {
        case let (tr, _, 0, 0):
            radius = tr
            self.corners = [.topRight, .topLeft]
        default:
            radius = 0
            self.corners = []
        }
    }
    
    private func roundCorners(_ corners: UIRectCorner, radius: Int, fillColor: UIColor = .white) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientLayer.mask = maskLayer
        
        clipsToBounds = true
        
        path.close()
    }
}
