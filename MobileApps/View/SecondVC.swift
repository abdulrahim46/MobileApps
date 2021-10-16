//
//  SecondVC.swift
//  MobileApps
//
//  Created by Abdul Rahim on 16/10/21.
//

import Foundation
import UIKit

class SecondVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UINib(nibName: "AllTableViewCell", bundle: nil), forCellReuseIdentifier: AllTableViewCell.reuseIdentifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexpath) in
            
            //self.mobiles.remove(at: indexpath.row)
            self.table.deleteRows(at: [indexPath], with: .automatic)
            
        })
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: AllTableViewCell.reuseIdentifier, for: indexPath)
        //cell.textLabel?.text = "hey"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
