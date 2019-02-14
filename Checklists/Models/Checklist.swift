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
    var iconName = GK.Icon.noIcon
    var items: [ChecklistItem]
    
    init(name: String, iconName: String = GK.Icon.noIcon) {
        self.name = name
        self.iconName = iconName
        items = [ChecklistItem]()
        super.init()
    }
        
    func countUncheckedItems() -> Int {
        return items.filter { !$0.checked }.count
    }
    
    func sortItems() {
        items.sort(by: { itemList1, itemList2 in
            return itemList1.dueDate.compare(itemList2.dueDate) == .orderedAscending
        })
    }
}
