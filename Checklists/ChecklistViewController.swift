//
//  ViewController.swift
//  Checklists
//
//  Created by John Pavley on 1/10/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var cellText = ["bat", "cat", "cow", "dog", "pig", "unknown"]
    var cellMarks = [false, false, false, false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getCellText(at indexPath: IndexPath) -> String {
        return cellText[indexPath.row]
    }
    
    func configureCell(at indexPath: IndexPath, for cell: UITableViewCell) {
        
        if cellMarks[indexPath.row] {
            cell.accessoryType = .none
            cellMarks[indexPath.row] = false
            
        } else {
            cell.accessoryType = .checkmark
            cellMarks[indexPath.row] = true
        }
    }
    
    func getCellAccessoryType(at indexPath: IndexPath) -> UITableViewCell.AccessoryType {
        
        if cellMarks[indexPath.row] {
            return UITableViewCell.AccessoryType.checkmark
        } else {
            return UITableViewCell.AccessoryType.none
        }
    }
    
    
    // MARK:- Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellText.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        cell.accessoryType = getCellAccessoryType(at: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = getCellText(at: indexPath)
        
        return cell
    }

    // MARK:- Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            configureCell(at: indexPath, for: cell)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

