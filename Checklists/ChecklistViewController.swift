//
//  ViewController.swift
//  Checklists
//
//  Created by John Pavley on 1/10/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items = [ChecklistItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let cellText = ["bat", "cat", "cow", "dog", "pig", "unknown", "worm", "goat"]
        
        for i in 0..<cellText.count {
            let item = ChecklistItem()
            item.text = cellText[i]
            items.append(item)
        }
    }
    
    // MARK:- Actions
    
    // MARK:- Table Helpers
    
    func getCellText(at indexPath: IndexPath) -> String {
        return items[indexPath.row].text
    }
    
    func configureCellMark(with item: ChecklistItem, for cell: UITableViewCell) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.alpha = 1.0
        } else {
            label.alpha = 0.0
        }
    }
    
    func configureCellText(with item: ChecklistItem, for cell: UITableViewCell) {
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // MARK:- Add Item View Controller Delegates
    
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        addItem(item)
        navigationController?.popViewController(animated:true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        
        if let index = items.index(of: item) {
        
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureCellText(with: item, for: cell)
            }
        }
        
        navigationController?.popViewController(animated:true)
    }

    
    func addItem(_ item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    // MARK:- Navigation
    
    @discardableResult
    func configureDesination(to segue: UIStoryboardSegue) -> ItemDetailViewController {
        let controller = segue.destination as! ItemDetailViewController
        controller.delegate = self
        return controller
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            configureDesination(to: segue)
        } else if segue.identifier == "EditItem" {
            let controller = configureDesination(to: segue)
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
}

