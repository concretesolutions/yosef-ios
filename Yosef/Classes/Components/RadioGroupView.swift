//
//  RadioGroupView.swift
//  Yosef
//
//  Created by Emannuel Carvalho on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class RadioGroupView: UIView, RadioItemDelegate {
    
    fileprivate let kButtonComponentDefaultCornerRadius = CGFloat(5)
    fileprivate let kButtonComponentDefaultBorderWidth = CGFloat(1)
    
    typealias Item = String
    
    weak var delegate: DynamicActionDelegate?
    
    override var tintColor: UIColor! {
        didSet {
            confirmButton.backgroundColor = tintColor
            stackView.subviews.forEach {
                $0.tintColor = tintColor
            }
        }
    }
    
    @objc lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()
    
    @objc lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    @objc lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.backgroundColor = tintColor
        button.setTitle("Confirmar", for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = kButtonComponentDefaultCornerRadius
        button.layer.borderWidth = kButtonComponentDefaultBorderWidth
        button.layer.borderColor = UIColor.clear.cgColor
        return button
    }()
    
    @objc func confirmButtonTapped() {
        if let item = selectedItem {
            delegate?.callAction(event: item)
        }
    }
    
    func setupConstraints() {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
        confirmButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        confirmButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(confirmButton)
    }
    
    var items = [Item]() {
        didSet {
            updateStackView()
        }
    }
    
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @objc var actionTitle = "" {
        didSet {
            confirmButton.setTitle(actionTitle, for: .normal)
        }
    }
    
    private func updateStackView() {
        for item in items {
            let view = RadioItem(title: item)
            view.delegate = self
            stackView.addArrangedSubview(view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(frame: .zero)
        buildHierarchy()
        setupConstraints()
        isUserInteractionEnabled = true
    }
    
    var selectedItem: Item? {
        didSet {
            confirmButton.isEnabled = selectedItem != nil
        }
    }
    
    func didSelectRadioItem(_ item: RadioItem) {
        selectedItem = item.title
    }
    
    func didDeselectRadioItem(_ item: RadioItem) {
        selectedItem = nil
    }
    
}
