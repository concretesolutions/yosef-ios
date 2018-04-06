//
//  UIButton+Properties.swift
//  Yosef
//
//  Created by Bruno Mazzo on 06/04/2018.
//

import UIKit

extension UIButton {
    var text: String? {
        get {
            return self.title(for: .normal)
        }
        
        set {
            self.setTitle(newValue, for: .normal)
        }
    }
    
    var textColor: UIColor? {
        get {
            return self.titleColor(for: .normal)
        }
        set {
            self.setTitleColor(newValue, for: .normal)
        }
    }
}
