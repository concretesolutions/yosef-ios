//
//  LabelComponent.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

fileprivate enum LabelViewProperty: String {
    case text = "text"
    case textColor = "textColor"
    case backgroundColor = "backgroundColor"
    case textSize = "textSize"
    case textStyle = "textStyle"
    case margin = "margin"
}

class LabelComponent: BaseComponent {
    
    private var propertyDictionary: [LabelViewProperty: AnyPropertyApplier<UILabel>?] =
        [.text: AnyPropertyApplier(KeyPathApplier(\UILabel.text)),
         .textColor: AnyPropertyApplier(KeyPathApplier(\UILabel.textColor)),
         .backgroundColor: AnyPropertyApplier(KeyPathApplier(\UILabel.backgroundColor)),
         .textSize: AnyPropertyApplier(FontSizeApplier<UILabel>()),
         .textStyle: AnyPropertyApplier(FontStyleApplier<UILabel>()),
         .margin: AnyPropertyApplier(EmptyApplier<UILabel>())]
    
    fileprivate let kLabelComponentType = "text"
    fileprivate let kLabelComponentTitleInsetTop = CGFloat(4)
    fileprivate let kLabelComponentTitleInsetBottom = CGFloat(4)
    fileprivate let kLabelComponentTitleInsetLeft = CGFloat(8)
    fileprivate let kLabelComponentTitleInsetRight = CGFloat(8)
    fileprivate let kLabelComponentNumberOfLines = 5
    fileprivate let kLabelComponentLeadingConstraint = CGFloat(16)
    fileprivate let kButtonComponentTrailingConstraint = CGFloat(-16)
    fileprivate let kLabelComponentTopConstraint = CGFloat(0)
    fileprivate let kLabelComponentHeightConstraint = CGFloat(0)
    fileprivate let kLabelComponentDefaultMultiplierConstraint = CGFloat(1)
    
    fileprivate var label: UILabel!
    
    override func applyViewsFromJson(dynamicComponent: DynamicComponent, actionDelegate: DynamicActionDelegate) throws -> UIView {
        
            self.label = UILabel()
            self.label.numberOfLines = kLabelComponentNumberOfLines
            self.label.adjustsFontSizeToFitWidth = true
            self.label.lineBreakMode = .byClipping
            self.label.baselineAdjustment = .alignCenters
            try self.addProperties(properties: dynamicComponent.properties)
        return self.label
    }
    
    // MARK: Setup Properties
    
    private func setupConstraints(view: UIView) {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.setContentHuggingPriority(.required, for: .vertical)
        self.label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: kLabelComponentTitleInsetTop).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: kLabelComponentTitleInsetBottom).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: kLabelComponentTitleInsetLeft).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: kLabelComponentTitleInsetRight).isActive = true
    }
    
    private func addProperties(properties: [DynamicProperty]?) throws {
        try properties?.forEach({
            try self.identityAndApplyProperties(property: $0)
        })
    }
    
    private func identityAndApplyProperties(property: DynamicProperty) throws {
        guard let textViewProperty = LabelViewProperty(rawValue: property.name),
            let applier = propertyDictionary[textViewProperty] else {
                throw ParseError.unknownProperty
        }
        
        _ = try applier?.apply(value: property.value, to: label)
    }
}

