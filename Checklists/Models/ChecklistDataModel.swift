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
    
    init() {
        lists = [Checklist]()
        loadChecklists()
        registerDefaults()
    }
    
    func registerDefaults() {
        let dictionary = [ "ChecklistIndex": -1 ]
        UserDefaults.standard.register(defaults: dictionary)
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

