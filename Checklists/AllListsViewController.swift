//
//  AllListsViewController.swift
//  Checklists
//
//  Created by John Pavley on 1/24/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    
    let cellIdentifier = "ChecklistCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        cell.textLabel!.text = "List \(indexPath.row)"

        return cell
    }
}
