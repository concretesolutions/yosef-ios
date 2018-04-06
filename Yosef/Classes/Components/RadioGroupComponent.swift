//
//  RadioGroupComponent.swift
//  Yosef
//
//  Created by Emannuel Carvalho on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class RadioGroupComponent: ViewComponent {

    private var radioView: RadioGroupView?
    
    func createViewFromJson(dynamicComponent: DynamicComponent,
                                     actionDelegate: DynamicActionDelegate) throws -> UIView {
        
            var items = [String]()
            for child in dynamicComponent.children {
                let item = child
                    .properties
                    .filter { $0.name == "text" }
                    .first?
                    .value as? String ?? ""
                items.append(item)
            }
            let title = dynamicComponent
                .properties
                .filter { $0.name == "text" }
                .first?
                .value as? String ?? ""
            let radioView = RadioGroupView()
            self.radioView = radioView
            radioView.translatesAutoresizingMaskIntoConstraints = false
            radioView.items = items
            radioView.title = title
            radioView.delegate = actionDelegate
//            view.addSubview(radioView)
//            radioView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//            radioView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//            radioView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//            radioView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            //...
//            radioView.heightAnchor.constraint(equalToConstant: 100 + CGFloat(items.count)*44).isActive = true
            //...
            add(properties: dynamicComponent.properties)
//            view.setNeedsLayout()
        
        return radioView
    }
    
    let propertyNamesTranslator = [
        "backgroundColor": "tintColor",
        "textColor": "titleLabel.textColor",
        "text": "actionTitle"
    ]
    
    let specialProperties = [String]()
    
}

extension RadioGroupComponent {
    
    private func add(properties: [DynamicProperty]?) {
        guard let properties = properties else { return }
        for p in properties.filter({ !specialProperties.contains($0.name) }) {
            let key = propertyNamesTranslator[p.name] ?? (p.name)
            radioView?.setValue(p.value, forKeyPath: key)
        }
    }
    
    private func handle(specialProperties properties: [DynamicProperty]) {
    }
    
}

protocol RadioItemDelegate: class {
    func didSelectRadioItem(_ item: RadioItem)
    func didDeselectRadioItem(_ item: RadioItem)
}



class RadioItem: UIView {
    
    init(title: String? = nil) {
        self.title = title
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
        titleLabel.text = title
        backgroundColor = .white
        setupTap()
        setupObserver()
    }
    
    override var tintColor: UIColor! {
        didSet {
            selectionIndicator.tintColor = tintColor
        }
    }
    
    weak var delegate: RadioItemDelegate?
    
    @objc func observeTap(_ notification: Notification) {
        guard let item = notification.object as? RadioItem else {
            return
        }
        if item !== self && item.superview == superview {
            selectionIndicator.isSelected = false
        }
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(observeTap(_:)),
                                               name: .radioButtonTapped,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTap()
    }
    
    func setupTap() {
        for gesture in gestureRecognizers ?? [] {
            removeGestureRecognizer(gesture)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }
    
    @objc func didTap() {
        selectionIndicator.isSelected = !selectionIndicator.isSelected
        NotificationCenter.default.post(name: .radioButtonTapped, object: self)
        selectionIndicator.isSelected ?
            delegate?.didSelectRadioItem(self) :
            delegate?.didDeselectRadioItem(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    lazy var selectionIndicator: SelectionView = {
        let view = SelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func buildHierarchy() {
        addSubview(selectionIndicator)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        selectionIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
        selectionIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        selectionIndicator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        selectionIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectionIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: selectionIndicator.trailingAnchor, constant: 8).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

class SelectionView: UIView {
    
    var isSelected: Bool = false {
        didSet {
            selectionIndicatorView.isHidden = !isSelected
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            layer.borderColor = tintColor.cgColor
            selectionIndicatorView.backgroundColor = tintColor
        }
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        layer.borderColor = tintColor.cgColor
        layer.borderWidth = 3
        addSubview(selectionIndicatorView)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = min(frame.width, frame.height)
        layer.cornerRadius = size/2
        selectionIndicatorView.isHidden = !isSelected
    }
    
    lazy var selectionIndicatorView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 5
        view.backgroundColor = tintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupConstraints() {
        selectionIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectionIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectionIndicatorView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        selectionIndicatorView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        setNeedsLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

extension Notification.Name {
    static let radioButtonTapped = Notification.Name(rawValue: "radioButtonTapped")
}
