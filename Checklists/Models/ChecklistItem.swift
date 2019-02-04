//
//  ChecklistItem.swift
//  Checklists
//
//  Created by John Pavley on 1/11/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    
    init(text: String = "", checked: Bool = false) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked() {
        checked = !checked
    }
}
