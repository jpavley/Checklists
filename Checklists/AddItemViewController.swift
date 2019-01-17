//
//  AddItemViewController.swift
//  Checklists
//
//  Created by John Pavley on 1/17/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done() {
        navigationController?.popViewController(animated: true)
        print(textField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK:- Table View Delegations
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}
