//
//  ViewController.swift
//  Checklists
//
//  Created by John Pavley on 1/10/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var items = [CheckListItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let cellText = ["bat", "cat", "cow", "dog", "pig", "unknown", "worm", "goat"]
        
        for i in 0..<cellText.count {
            let item = CheckListItem()
            item.text = cellText[i]
            items.append(item)
        }
    }
    
    func getCellText(at indexPath: IndexPath) -> String {
        return items[indexPath.row].text
    }
    
    func configureCellMark(with item: CheckListItem, for cell: UITableViewCell) {
        
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureCellText(with item: CheckListItem, for cell: UITableViewCell) {
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    // MARK:- Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = items[indexPath.row]
        configureCellMark(with: item, for: cell)
        configureCellText(with: item, for: cell)
        
        return cell
    }

    // MARK:- Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCellMark(with: item, for: cell)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

