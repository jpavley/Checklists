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
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
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
        let dictionary = ["ChecklistIndex": -1, "FirstTime": true] as [String : Any]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
    // MARK:- Document Data Management
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
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
            } catch {
                print("Error decoding checklist: \(error.localizedDescription)")
            }
        } else {
            print("Could not find Checklists.plist")
        }
    }

}

