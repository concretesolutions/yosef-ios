//
//  ComponentsMock.swift
//  Yosef_Tests
//
//  Created by Emannuel Carvalho on 08/02/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

@testable import Yosef

class ComponentsMocks {
    
    var labelMock: DynamicComponent {
        return DynamicComponent(type: "text",
                                  children: [],
                                  properties: [
                                    property([
                                        "name": "text",
                                        "type": "string",
                                        "value": "Hello, world!"
                                        ]),
                                    property([
                                        "name": "textColor",
                                        "type": "color",
                                        "value": "#333839"
                                        ]),
                                    property([
                                        "name": "textSize",
                                        "type": "dimen",
                                        "value": "25"
                                        ]),
                                    property([
                                        "name": "backgroundColor",
                                        "type": "color",
                                        "value": "#aaaaaa"
                                        ])
            ])
    }
    
    var buttonMock: DynamicComponent {
        return DynamicComponent(type: "button",
                                  children: [],
                                  properties: [
                                    property([
                                        "name": "text",
                                        "type": "string",
                                        "value": "Confirmar"
                                        ]),
                                    property([
                                        "name": "action",
                                        "type": "string",
                                        "value": "closeFlow"
                                        ]),
                                    property([
                                        "name": "textColor",
                                        "type": "color",
                                        "value": "#333839"
                                        ]),
                                    property([
                                        "name": "textSize",
                                        "type": "dimen",
                                        "value": "25"
                                        ]),
                                    property([
                                        "name": "backgroundColor",
                                        "type": "color",
                                        "value": "#ffffff"
                                        ])
            ])
    }
    
    var imageMock: DynamicComponent {
        let path = Bundle(for: type(of: self)).path(forResource: "Saldo", ofType: "png")!
        return DynamicComponent(type: "image",
                                  children: [],
                                  properties: [
                                    property([
                                        "name": "url",
                                        "type": "string",
                                        "value": path
                                        ]),
                                    property([
                                        "name": "width",
                                        "type": "dimen",
                                        "value": "25"
                                        ]),
                                    property([
                                        "name": "height",
                                        "type": "dimen",
                                        "value": "25"
                                        ])
            ])
    }
    
    var elementGroup: DynamicComponent {
        return try! DynamicComponent(dictionary: loadComponent(fileName: "Step1") ?? [:])
    }
    
    var radioGroup: DynamicComponent {
        return try! DynamicComponent(dictionary: loadComponent(fileName: "Step2") ?? [:])
    }
    
    func property(_ info: [String: Any]) -> DynamicProperty {
        return try! DynamicProperty(dictionary: info)
    }
    
    
    func loadComponent(fileName: String) -> [String: Any]? {
        if let path = Bundle(for: type(of: self))
            .path(forResource: fileName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                let dict = try (JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any])
                return dict
            } catch {
                return nil
            }
        }
        return nil
    }
}
