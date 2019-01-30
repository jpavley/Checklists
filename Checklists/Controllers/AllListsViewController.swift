//
//  AllListsViewController.swift
//  Checklists
//
//  Created by John Pavley on 1/24/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

/// Root view controller.
/// - UINavigationControllerDelegate means the object gets notified when the back button on the navigation bar is pressed.
/// - UITableViewController means the object get notified when the user interacts with the table view.
/// - ListDetailViewControllerDelegate is a bespoke protocol that means the object is notified when the user makes changes to a checklist.
class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    let cellIdentifier = "ChecklistCell"
    var dataModel: ChecklistDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        navigationController?.delegate = self
        
        let index = UserDefaults.standard.integer(forKey: "ChecklistIndex")
        
        if index != -1 {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        controller.delegate = self
        
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let list = dataModel.lists[indexPath.row]
        
        cell.textLabel!.text = list.name
        cell.accessoryType = .detailButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = dataModel.lists[indexPath.row]
        
        // save the index of the list that the user is about to open include app is terminated
        UserDefaults.standard.set(indexPath.row, forKey: "ChecklistIndex")
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowChecklist" {
            
            let controller = segue.destination as! ChecklistViewController
            controller.checklist = sender as? Checklist
            
        } else if segue.identifier == "AddChecklist" {
            
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }
    
    // MARK:- List Detail View Controller Delegate
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        
        if let index = dataModel.lists.index(of: checklist) {
            
            let indexPath = IndexPath(row: index, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Navigation Controller Delegates
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        // Was the back button tapped?
        // Woah: note the 3 equal signs, not just equal value (==) but identitical object (===)!
        if viewController === self {
            // set the index for the checklist opened to n/a (-1)
            UserDefaults.standard.set(-1, forKey: "ChecklistIndex")
        }
    }
}
