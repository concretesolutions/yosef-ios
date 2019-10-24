//
//  ElementList.swift
//  Yosef
//
//  Created by kaique.pantosi on 15/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class ElementList: ViewComponent {
    
    func createViewFromJson(dynamicComponent: DynamicComponent,
                                     actionDelegate: DynamicActionDelegate) throws -> UIView {
        
        let listView = ElementListView(items: dynamicComponent.children, delegate: actionDelegate, properties: dynamicComponent.properties)
        listView.translatesAutoresizingMaskIntoConstraints = false
        return listView
    }
}

private class ElementListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        return tableView
    }()
    
    var components = [DynamicComponent]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: DynamicActionDelegate
    var properties: [DynamicProperty]
    
    var cellBackgroundColor: UIColor = .white
    
    init(items: [DynamicComponent], delegate: DynamicActionDelegate, properties: [DynamicProperty]) {
        self.components = items
        self.delegate = delegate
        self.properties = properties
        super.init(frame: .zero)
        setupViews()
    }
    
    func setupViews() {
        applyProperties()
        addSubview(tableView)
        self.topAnchor(equalTo: tableView.topAnchor)
            .bottomAnchor(equalTo: tableView.bottomAnchor)
            .leadingAnchor(equalTo: tableView.leadingAnchor)
            .trailingAnchor(equalTo: tableView.trailingAnchor)
        tableView.reloadData()
    }
    
    func applyProperties() {
        for property in properties where property.name == "backgroundColor" {
            if let color = property.value as? UIColor {
                cellBackgroundColor = color
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        for v in cell.contentView.subviews {
            v.removeFromSuperview()
        }
        let component = components[indexPath.row]
        let view = try! DynamicView.createView(dynamicsComponent: component,
                                          actionDelegate: delegate)
        cell.contentView.addSubview(view)
        cell.contentView.backgroundColor = cellBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let marginApplier = MarginApplier()
        marginApplier.tryApplyMargin(component: component, to: view, in: cell.contentView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
