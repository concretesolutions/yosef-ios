//
//  BaseModelProtocol.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

protocol BaseModelProtocol {
    
    static func fillWithDictionary<T>(_ variable: inout T, key: String, dictionary: [String : Any])
    
}

extension BaseModelProtocol {
    
    /**
     fill a property from a dictionary
     
     - parameter variable:   field to be filled
     - parameter key:        key from dictionary
     - parameter dictionary: dictionary
     */
    static func fillWithDictionary<T>(_ variable: inout T, key: String, dictionary: [String : Any]) {
        if let tempField = dictionary[key] as? T {
            variable = tempField
        }
    }
    
}
