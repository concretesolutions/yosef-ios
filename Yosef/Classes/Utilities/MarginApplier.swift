//
//  MarginApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 26/03/18.
//

class MarginApplier {
    func tryApplyMargin(component: DynamicComponent, to view: UIView, in container: UIView) {
        let gravity = component.properties?.first(where: { $0.name == "margin" })?.value as? Margin ?? Margin(left: 0, right: 0, top: 0, bottom: 0)
        
        container
            .topAnchor(equalTo: view.topAnchor, constant: -gravity.top)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: -gravity.left)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: gravity.right)
            .bottomAnchor(equalTo: view.bottomAnchor, constant: gravity.bottom)
    }
}
