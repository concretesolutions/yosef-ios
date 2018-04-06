//
//  LabelComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class LabelComponent: PropertyBasedViewComponent {
    func createView(actionDelegate: DynamicActionDelegate) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.baselineAdjustment = .alignCenters
        return label
    }
    
    var propertyDictionary: [String: AnyPropertyApplier<UILabel>] =
        ["text": AnyPropertyApplier(KeyPathApplier(\UILabel.text)),
         "textColor": AnyPropertyApplier(KeyPathApplier(\UILabel.textColor)),
         "backgroundColor": AnyPropertyApplier(KeyPathApplier(\UILabel.backgroundColor)),
         "textSize": AnyPropertyApplier(FontSizeApplier<UILabel>()),
         "textStyle": AnyPropertyApplier(FontStyleApplier<UILabel>()),
         "margin": AnyPropertyApplier(EmptyApplier<UILabel>())]    
}

