//
//  GlobalConstants.swift
//  Checklists
//
//  Created by John Pavley on 2/10/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

typealias GK = GlobalConstants

struct GlobalConstants {
    
    struct Index {
        static let noIndex = -1
    }
    
    struct Key {
        static let checkListIndex = "ChecklistIndex"
        static let firstTime = "FirstTime"
        static let list = "List"
        static let checkListItemID = "ChecklistItemID"
    }
    
    struct Path {
        static let pList = "Checklists.plist"
    }
    
    struct View {
        
        struct cellID {
            static let checklistCell = "ChecklistCell"
            static let checklistItem = "ChecklistItem"
            static let iconCell = "IconCell"
        }
        
        struct segueID {
            static let showChecklist = "ShowChecklist"
            static let addChecklist = "AddChecklist"
            static let addItem = "AddItem"
            static let editItem = "EditItem"
            static let pickIcon = "PickIcon"
        }
        
        struct storyboardID {
            static let listDetailViewController = "ListDetailViewController"
        }
    }
}
