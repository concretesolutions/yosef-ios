//
//  ViewController.swift
//  Yosef
//
//  Created by Guilherme Bayma on 03/05/2018.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import Yosef

class ViewController: UIViewController {

    /*
     *  Name of JSON file
     */
    let jsonName = "List"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJsonTest()
    }
    
    func loadJsonTest() {
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options:.mutableLeaves)
                if let jResult = jsonResult as? [String: Any] {
                    
                    let comp = DynamicComponent.parse(dictionary: jResult) as DynamicComponent
                    let view = try! DynamicView.createView(dynamicsComponent: comp, actionDelegate: self)
                    addView(view)
                }
            } catch {
                print("Error Reading JSON")
            }
        }
    }
    
    func addView(_ view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
}

extension ViewController: DynamicActionDelegate {
    func callAction(sender: String) {
        print(sender)
    }
}
