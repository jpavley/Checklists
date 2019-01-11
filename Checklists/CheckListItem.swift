//
//  CheckListItem.swift
//  Checklists
//
//  Created by John Pavley on 1/11/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

class CheckListItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
