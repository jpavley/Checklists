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
    var checklists = [Checklist]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let listNames = ["To Do", "To Buy", "To Read", "To Watch", "To Eat"]

        for i in 0..<listNames.count {
            let list = Checklist(name: listNames[i])
            checklists.append(list)
        }


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let list = checklists[indexPath.row]
        
        cell.textLabel!.text = list.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowChecklist", sender: nil)
    }
}
