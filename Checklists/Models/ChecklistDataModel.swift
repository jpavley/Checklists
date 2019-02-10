//
//  ChecklistDataModel.swift
//  Checklists
//
//  Created by John Pavley on 1/30/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

class ChecklistDataModel {
    
    var lists: [Checklist]
    
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: GK.Key.checkListIndex)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GK.Key.checkListIndex)
            // force user defaults to set the new value immediately in the case of a sudden termination event
            UserDefaults.standard.synchronize()
        }
    }

    init() {
        lists = [Checklist]()
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    func registerDefaults() {
        // if ChecklistIndex is -1 then no checklist was opened
        // if FirstTime is true then this is the first time the user has launced the app
        let dictionary = ["ChecklistIndex": GK.Index.noIndex, GK.Key.firstTime: true] as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: GK.Key.firstTime)
        
        if firstTime {
            let checklist = Checklist(name: GK.Key.list)
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: GK.Key.firstTime)
            userDefaults.synchronize()
        }
    }
    
    func sortChecklists() {
        lists.sort(by: { list1, list2 in
            return list1.name.localizedStandardCompare(list2.name) == .orderedAscending })
    }
    
    // MARK:- Document Data Management
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent(GK.Path.pList)
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding checklist: \(error.localizedDescription)")
        }
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            
            let decoder = PropertyListDecoder()
            
            do {
                lists = try decoder.decode([Checklist].self, from: data)
                sortChecklists()
            } catch {
                print("Error decoding checklist: \(error.localizedDescription)")
            }
        } else {
            print("Could not find \(GK.Path.pList)")
        }
    }
    
    // MARK:- local notification
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: GK.Key.checkListItemID)
        userDefaults.set(itemID + 1, forKey: GK.Key.checkListItemID)
        userDefaults.synchronize() // force user default to update immediately
        return itemID
    }

}

