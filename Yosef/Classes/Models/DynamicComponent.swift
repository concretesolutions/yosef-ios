//
//  DynamicComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

public class DynamicComponent: NSObject, BaseModelProtocol {

    // MARK: Constants
    
    fileprivate static let kType = "type"
    fileprivate static let kChildren = "children"
    fileprivate static let kProperties = "properties"
    
    // MARK: Properties
    
    var type: String?
    var children: [DynamicComponent]?
    var properties: [DynamicProperty]?
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    init(type: String?, children: [DynamicComponent]?, properties: [DynamicProperty]?) {
        self.type = type
        self.children = children
        self.properties = properties
    }
    
    public static func parse(dictionary: [String: Any]) -> DynamicComponent {
        let dynamicComponent = DynamicComponent()
        dynamicComponent.children = self.parseChildrenArray(dictionary: dictionary)
        dynamicComponent.properties = self.parsePropertiesArray(dictionary: dictionary)
        fillWithDictionary(&dynamicComponent.type, key: kType, dictionary: dictionary)
        return dynamicComponent
    }
    
    static private func parseChildrenArray(dictionary: [String: Any]) -> [DynamicComponent] {
        var childrenArray = [DynamicComponent]()
        if let childrenDictionary = dictionary[kChildren] as? [[String : Any]] {
            for item in childrenDictionary {
                childrenArray.append(DynamicComponent.parse(dictionary: item))
            }
        }
        return childrenArray
    }
    
    static private func parsePropertiesArray(dictionary: [String: Any]) -> [DynamicProperty] {
        if let propertiesDictionary = dictionary[kProperties] as? [[String : Any]] {
           return propertiesDictionary.flatMap({
                return try! DynamicProperty(dictionary: $0)
            })
        }
        return []
    }
    
}
