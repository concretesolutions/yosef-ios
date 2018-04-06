//
//  DynamicViewProtocols.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

@objc public protocol DynamicActionDelegate: class {
    func callAction(sender: String)
}

//protocol ComponentDelegate: class {
//    func applyViewsFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView
//}
