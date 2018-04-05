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
    case scaleType = "scaleType"
    case aspectRatio = "aspectRatio"
    case margin = "margin"
}

class ImageComponent: BaseComponent {
    
    private var propertyDictionary: [ImageProperty: AnyPropertyApplier<UIImageView>] =
        [.url: AnyPropertyApplier(KingfisherApplier()),
         .width: AnyPropertyApplier(SelfConstraintApplier<UIImageView>(dimension: .width)),
         .height: AnyPropertyApplier(SelfConstraintApplier<UIImageView>(dimension: .height)),
         .scaleType: AnyPropertyApplier(ScaleTypeApplier<UIImageView>()),
         .aspectRatio: AnyPropertyApplier(aspectRatioApplier<UIImageView>()),
         .margin: AnyPropertyApplier(EmptyApplier<UIImageView>()),
    ]
    
    fileprivate let kImageComponentType = "image"
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func applyViewsFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView {
        try addProperties(properties: dynamicComponent.properties)
        return self.imageView
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
                throw ParseError.unknownProperty(property.name)
        }
        
        _ = try applier.apply(value: property.value, to: imageView)
    }
}
