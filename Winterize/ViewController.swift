//
//  ViewController.swift
//  Winterize
//
//  Created by Christopher Bonuel on 10/8/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class ViewController: UIViewController {
    let dataController: DataController
    var zones: Results<Zone>!
    let bag = DisposeBag()
    
    // MARK: - UI
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
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
        
        let realm = try! Realm()
        zones = realm.objects(Zone.self).sorted(byKeyPath: "number")
        
        bindZonesToTableView()
    }
    
    func bindZonesToTableView() {
        Observable.changeset(from: zones)
            .subscribe(onNext: { [unowned self] _, changeSet in
                if let changeSet = changeSet {
                    self.tableView.apply(changeSet)
                } else {
                    self.tableView.reloadData()
                }
            })
            .disposed(by: bag)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zone = zones[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ZoneCell.reuseIdentifier) as! ZoneCell
        return cell.configured(with: zone)
    }
}

