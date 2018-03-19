//
//  BaseComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class BaseComponent: NSObject, ComponentDelegate {
    
    override required init() {
        super.init()
    }
    
    func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws { }
    
}
