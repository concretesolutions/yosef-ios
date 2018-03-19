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
    
    private var propertyDictionary: [ImageProperty: PropertyApplier<UIImageView>] = [.url: KingfisherApplier(),
                                                                                     .width: WritableKeyPathApplicator(\UIImageView.frame.width),
                                                                                     .height: WritableKeyPathApplicator(\UIImageView.frame.height)]
    
    fileprivate let kImageComponentType = "image"
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    fileprivate var height: CGFloat?
    fileprivate var width: CGFloat?
    
    override func applyViewsFromJson(view: UIView, dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) {
        if dynamicComponent.type == kImageComponentType {
            view.addSubview(imageView)
            addProperties(dynamicComponent.properties)
            setUpConstraints(view)
        }
    }
    
}

// MARK: - Properties

extension ImageComponent {
    private func addProperties(_ properties: [DynamicProperty]?) {
        if let properties = properties {
            for property in properties {
                self.identifyAndApplyProperty(property)
            }
        }
    }
    
    private func identifyAndApplyProperty(_ property: DynamicProperty) {
        if let imageProperty = ImageProperty(rawValue: property.name) {
            switch imageProperty {
            case .url:
                getImageFromURL(property.value)
                break
            case .width:
                setWidth(property.value)
                break
            case .height:
                setHeight(property.value)
                break
            }
        }
    }
    
    private func getImageFromURL(_ url: String?) {
        if let url = url {
            imageView.kf.setImage(with: URL(string: url))
        }
    }
    
    private func setWidth(_ width: String?) {
        if let width = width, let widthValue = Float(width) {
            let cgWidth = CGFloat(widthValue)
            self.width = cgWidth
        }
    }
    
    private func setHeight(_ height: String?) {
        if let height = height, let heightValue = Float(height) {
            let cgHeight = CGFloat(heightValue)
            self.height = cgHeight
        }
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
            .heightAnchor(equalTo: height ?? 0)
            .widthAnchor(equalTo: width ?? 0)
    }
}
