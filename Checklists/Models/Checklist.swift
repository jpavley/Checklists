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
    var iconName = "Appointments"
    var items: [ChecklistItem]
    
    init(name: String) {
        self.name = name
        items = [ChecklistItem]()
        super.init()
    }
    
//    func countUncheckedItems() -> Int {
//        var count = 0
//        for item in items where !item.checked {
//            count += 1
//        }
//
//        return count
//    }
    
//    func countUncheckedItems() -> Int {
//        return items.reduce(0) { c, item in c + (item.checked ? 0 : 1) }
//    }
    
    func countUncheckedItems() -> Int {
        return items.filter { !$0.checked }.count
    }
}
