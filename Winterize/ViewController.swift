//
//  ViewController.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/8/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dataController: DataController
    
    // MARK: - UI
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ZoneCell.self, forCellReuseIdentifier: ZoneCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewWillLayoutSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Init
    
    init(dataController: DataController = DataController()) {
        self.dataController = dataController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "Rachio"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = .rachioBlue
    }
}

