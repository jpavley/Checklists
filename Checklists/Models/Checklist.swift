//
//  Checklist.swift
//  Checklists
//
//  Created by John Pavley on 1/25/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items: [ChecklistItem]
    
    init(name: String) {
        self.name = name
        items = [ChecklistItem]()
        super.init()
    }
}
