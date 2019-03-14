//
//  DataModel.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
let ModelData = DataModel()
class DataModel{
    var checkListArray:[Checklist] = [Checklist]()
    
    static var documentDirectory:URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static var dataFileUrl:URL {
        return documentDirectory.appendingPathComponent("CheckLists").appendingPathExtension("json")
    }
    
    @objc func save(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let jsonData = try encoder.encode(checkListArray)
            try jsonData.write(to: AllListViewController.dataFileUrl)
        }
        catch{}
    }
    
    func load(){
        do{
            let importedData = try Data(contentsOf: AllListViewController.dataFileUrl)
            try checkListArray = JSONDecoder().decode([Checklist].self, from: importedData)
        }catch{
        }
    }
    
    init(){
        load()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(save),
                                                name: UIApplication.didEnterBackgroundNotification,
                                                object: nil)
    }
}
