//
//  DynamicProperty.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class DynamicProperty: NSObject, BaseModelProtocol {

    // MARK: Constants
    
    fileprivate static let kName = "name"
    fileprivate static let kType = "type"
    fileprivate static let kValue = "value"
    
    // MARK: Properties
    
    var name: String?
    var type: String?
    var value: String?
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    init(name: String?, type: String?, value: String?) {
        self.name = name
        self.type = type
        self.value = value
    }
    
    static func parse(dictionary: [String: Any]) -> DynamicProperty {
        let dynamicPropety = DynamicProperty()
        fillWithDictionary(&dynamicPropety.name, key: kName, dictionary: dictionary)
        fillWithDictionary(&dynamicPropety.type, key: kType, dictionary: dictionary)
        fillWithDictionary(&dynamicPropety.value, key: kValue, dictionary: dictionary)
        return dynamicPropety
    }
    
}

extension DynamicProperty {
    
    override var debugDescription: String {
        let name = self.name ?? ""
        let type = self.type ?? ""
        let value = self.value ?? ""
        return "DynamicProperty:\n\tname: \(name)\n\ttype: \(type)\n\tvalue: \(value)"
    }
    
}
