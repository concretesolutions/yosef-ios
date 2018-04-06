//
//  MarginApplier.swift
//  Yosef
//
//  Created by kaique.pantosi on 26/03/18.
//

class MarginApplier {
    
    private func findMargin(component: DynamicComponent) -> Margin? {
        return component.properties.first(where: { $0.name == "margin" })?.value as? Margin
    }
    
    func applyIfExistMargin(component: DynamicComponent, to view: UIView, in container: UIView) {
        if let margin = self.findMargin(component: component) {
            self.applyMargir(margin: margin, to: view, in: container)
        }
    }
    
    func tryApplyMargin(component: DynamicComponent, to view: UIView, in container: UIView) {
        let margin = self.findMargin(component: component) ?? Margin(left: 0, right: 0, top: 0, bottom: 0)
        
        self.applyMargir(margin: margin, to: view, in: container)
    }
    
    func applyMargir(margin: Margin, to view: UIView, in container: UIView) {
        container
            .topAnchor(equalTo: view.topAnchor, constant: -margin.top)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: -margin.left)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: margin.right)
            .bottomAnchor(equalTo: view.bottomAnchor, constant: margin.bottom)
    }
}
