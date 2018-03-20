//
//  DynamicView.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

public class DynamicView: NSObject {

    // TODO: mudar assinatura e tipar o dynamicsComponent
    
    /// Creates and returns a view according to the informations provided in the DynamicsComponent.
    ///
    /// - Parameters:
    ///   - dynamicsComponent: The object representing the informations of the view to be created and its children
    ///   - actionDelegate: The delegate to be passed to the newly created view if its a control
    /// - Returns: a `UIView` created according to the informations in the `dynamicsComponent`.
    public static func createView(dynamicsComponent: DynamicComponent,
                                  actionDelegate: DynamicActionDelegate) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        if let componentType = components[dynamicsComponent.type ?? ""] {
            let comp = componentType.init()
            try! comp.applyViewsFromJson(view: view,
                                    dynamicComponent: dynamicsComponent,
                                    actionDelegate: actionDelegate)
        }
        return view
    }
    
    // Add new components here
    private static let components = [
        "text": LabelComponent.self,
        "button": ButtonComponent.self,
        "textField": TextFieldComponent.self,
        "elementGroup": ElementGroupComponent.self,
        "radioGroupButton": RadioGroupComponent.self,
        "image": ImageComponent.self,
        "animation": LottieComponent.self,
        "elementList": ElementList.self
    ]
    
}
