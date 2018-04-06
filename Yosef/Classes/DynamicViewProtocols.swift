//
//  DynamicViewProtocols.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

@objc public protocol DynamicActionDelegate: class {
    func callAction(event: String)
}


typealias Action = () -> ()

class MultiActionDelegate: DynamicActionDelegate {
    var actions: [String: [Action]] = [:]
    
    func add(action: @escaping Action, forEvent event: String) {
        var actions = self.actions[event] ?? []
        actions.append(action)
        self.actions[event] = actions
    }
    
    func callAction(event: String) {
        self.actions[event]?.forEach { $0() }
    }
}
