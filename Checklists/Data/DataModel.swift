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
            try jsonData.write(to: DataModel.dataFileUrl)
        }
        catch{}
    }
    
    func load(){
        do{
            let importedData = try Data(contentsOf: DataModel.dataFileUrl)
            try checkListArray = JSONDecoder().decode([Checklist].self, from: importedData)
        }catch{
        }
    }
    
    init(){
        load()
        sortCheckList()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(save),
                                                name: UIApplication.didEnterBackgroundNotification,
                                                object: nil)
    }
    
    func sortCheckList(){
        checkListArray = checkListArray.sorted { $0.name.lowercased() < $1.name.lowercased() }
        checkListArray.forEach { (singleCheckList) in
            singleCheckList.items = singleCheckList.items.sorted {$0.text.lowercased() < $1.text.lowercased()}
        }
    }
}
