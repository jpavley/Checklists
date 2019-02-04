//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by John Pavley on 1/25/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
    
    // MARK:- Outlets
    
    @IBOutlet weak var textField: UITextField!
    
    /// doneBarButton states
    /// - Disabled: when view appears
    /// - Enabled: when list name or icon changes
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK:- Properties
    
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
    var iconName = "Folder"
    
    // MARK:- View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checklistToEdit = checklistToEdit {
            title = "Edit Checklist"
            iconName = checklistToEdit.iconName
        }
        
        iconImageView.image = UIImage(named: iconName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        // Setting the content of textField doesn't work in viewDidLoad
        // but it works here. Mysterious!
        textField.text = checklistToEdit?.name
    }
    
    // MARK:- Actions
    
    @IBAction func cancel() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        
        if let checklist = checklistToEdit {
            
            checklist.name = textField.text!
            checklist.iconName = iconName
            
            delegate?.listDetailViewController(self, didFinishEditing: checklist)
        } else {
            
            let checklist = Checklist(name: textField.text!)
            checklist.iconName = iconName
            
            delegate?.listDetailViewController(self, didFinishAdding: checklist)
        }
    }
    
    // MARK:- Table View Delegates
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // if the icon section is tapped on, allow it!
        // (return nil means the tap is ignored
        // section 0: checklist name
        // section 1: checklist icon
        return indexPath.section == 1 ? indexPath : nil
    }
    
    // MARK:- Text Field Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        //doneBarButton.isEnabled = false
        return true
    }
    
    // MARK:- Icon Picker View Controller Delegate
    
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
        
        self.iconName = iconName
        iconImageView.image = UIImage(named: iconName)
        doneBarButton.isEnabled = true
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PickIcon" {
            
            let controller = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
}
