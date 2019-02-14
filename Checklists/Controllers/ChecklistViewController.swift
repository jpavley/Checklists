//
//  ViewController.swift
//  Checklists
//
//  Created by John Pavley on 1/10/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var checklist: Checklist!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        navigationItem.largeTitleDisplayMode = .never
        title = checklist.name
    }
    
    // MARK:- Table Helpers
    
    func getCellText(at indexPath: IndexPath) -> String {
        return checklist.items[indexPath.row].text
    }
    
    func configureCellMark(with item: ChecklistItem, for cell: UITableViewCell) {
        
        let label = cell.viewWithTag(GK.Tag.markLabel) as! UILabel
        
        if item.checked {
            label.alpha = 1.0
        } else {
            label.alpha = 0.0
        }
    }
    
    func configureCellText(with item: ChecklistItem, for cell: UITableViewCell) {
        
        let itemLabel = cell.viewWithTag(GK.Tag.itemLabel) as! UILabel
        itemLabel.text = item.text
        
        let dateLabel = cell.viewWithTag(GK.Tag.dueDateLabel) as! UILabel
        dateLabel.text = item.dueDateAsString
        
    }

    // MARK:- Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:GK.View.cellID.checklistItem, for: indexPath)
        
        let item = checklist.items[indexPath.row]
        configureCellMark(with: item, for: cell)
        configureCellText(with: item, for: cell)
        
        return cell
    }

    // MARK:- Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            configureCellMark(with: item, for: cell)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Swipe to delete function (if this function is overridden "swipe to delete" interaction is enabled)
        
        checklist.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // MARK:- Add Item View Controller Delegates
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        addItem(item)
        checklist.sortItems()
        tableView.reloadData()
        navigationController?.popViewController(animated:true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        editItem(item)
        checklist.sortItems()
        tableView.reloadData()
        navigationController?.popViewController(animated:true)
    }
    
    func editItem(_ item: ChecklistItem) {
        if let index = checklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureCellText(with: item, for: cell)
            }
        }
    }
    
    func addItem(_ item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        
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
        if segue.identifier == GK.View.segueID.addItem {
            configureDesination(to: segue)
        } else if segue.identifier == GK.View.segueID.editItem {
            let controller = configureDesination(to: segue)
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
}

