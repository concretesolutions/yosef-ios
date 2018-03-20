//
//  ElementList.swift
//  Yosef
//
//  Created by kaique.pantosi on 15/03/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class ElementList: BaseComponent {
    
    override func applyViewsFromJson(view: UIView,
                                     dynamicComponent: DynamicComponent,
                                     actionDelegate: DynamicActionDelegate) {
        if dynamicComponent.type == "elementList" {
            let listView = ElementListView(items: dynamicComponent.children ?? [], delegate: actionDelegate)
            listView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(listView)
            view.topAnchor(equalTo: listView.topAnchor)
                .bottomAnchor(equalTo: listView.bottomAnchor)
                .leadingAnchor(equalTo: listView.leadingAnchor)
                .trailingAnchor(equalTo: listView.trailingAnchor)
            view.setNeedsLayout()
        }
    }
    
}

private class ElementListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var components = [DynamicComponent]() {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: DynamicActionDelegate
    
    init(items: [DynamicComponent], delegate: DynamicActionDelegate) {
        self.components = items
        self.delegate = delegate
        super.init(frame: .zero)
        setupViews()
    }
    
    func setupViews() {
        addSubview(tableView)
        self.topAnchor(equalTo: tableView.topAnchor)
            .bottomAnchor(equalTo: tableView.bottomAnchor)
            .leadingAnchor(equalTo: tableView.leadingAnchor)
            .trailingAnchor(equalTo: tableView.trailingAnchor)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        for v in cell.contentView.subviews {
            v.removeFromSuperview()
        }
        let component = components[indexPath.row]
        let view = DynamicView.createView(dynamicsComponent: component,
                                          actionDelegate: delegate)
        view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(view)
        cell.contentView
            .topAnchor(equalTo: view.topAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
            .leadingAnchor(equalTo: view.leadingAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
        return cell
    }    
}
