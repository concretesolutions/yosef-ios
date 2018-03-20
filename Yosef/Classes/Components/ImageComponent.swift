//
//  ImageComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import Kingfisher

fileprivate enum ImageProperty: String {
    case url = "url"
    case width = "width"
    case height = "height"
}

class ImageComponent: BaseComponent {
    
    private var propertyDictionary: [ImageProperty: AnyPropertyApplier<UIImageView>] =
        [.url: AnyPropertyApplier(KingfisherApplier()),
         .width: AnyPropertyApplier(SelfConstraintApplier<UIImageView>(dimension: .width)),
         .height: AnyPropertyApplier(SelfConstraintApplier<UIImageView>(dimension: .height))
    ]
    
    fileprivate let kImageComponentType = "image"
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws {
        if dynamicComponent.type == kImageComponentType {
            view.addSubview(imageView)
            try addProperties(properties: dynamicComponent.properties)
            setUpConstraints(view)
        }
    }
    
}

// MARK: - Properties

extension ImageComponent {
    private func addProperties(properties: [DynamicProperty]?) throws {
        try properties?.forEach({
            try self.identityAndApplyProperties(property: $0)
        })
    }
    
    private func identityAndApplyProperties(property: DynamicProperty) throws {
        guard let textViewProperty = ImageProperty(rawValue: property.name),
            let applier = propertyDictionary[textViewProperty] else {
                throw ParseError.unknownProperty
        }
        
        _ = try applier.apply(value: property.value, to: imageView)
    }
}

// MARK: - Constraints

extension ImageComponent {
    private func setUpConstraints(_ view: UIView) {
        imageView
            .topAnchor(equalTo: view.topAnchor, constant: 0)
            .bottomAnchor(equalTo: view.bottomAnchor, constant: 0)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 0)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: 0)
    }
}
