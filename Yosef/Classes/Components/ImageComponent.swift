//
//  ImageComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class ImageComponent: PropertyBasedViewComponent {
    func createView(actionDelegate: DynamicActionDelegate) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    
    var propertyDictionary: [String: AnyPropertyApplier<UIImageView>] =
        ["url": AnyPropertyApplier(KingfisherApplier()),
         "width": AnyPropertyApplier(SelfConstraintApplier<UIImageView>(dimension: .width)),
         "height": AnyPropertyApplier(SelfConstraintApplier<UIImageView>(dimension: .height)),
         "scaleType": AnyPropertyApplier(ScaleTypeApplier<UIImageView>()),
         "aspectRatio": AnyPropertyApplier(aspectRatioApplier<UIImageView>()),
         "margin": AnyPropertyApplier(EmptyApplier<UIImageView>()),
    ]
    
}
