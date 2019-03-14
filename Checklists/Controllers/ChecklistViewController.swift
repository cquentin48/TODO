//
//  ViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

protocol ItemViewDelegate : class {
    func itemViewControllerDidCancel(_ controller: ListDetailViewController)
    func itemDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: [ChecklistItem])
    func itemDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: [ChecklistItem], indexAt: Int)
}

class ChecklistViewController: UITableViewController {
    var checkListItemsArray: [ChecklistItem] = []
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var checkBoxLabel: UILabel!
    var rawInput:String?
    var delegate:ItemViewDelegate?
    var list: Checklist!
    
    static var documentDirectory:URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static var dataFileUrl:URL {
        return documentDirectory.appendingPathComponent("CheckLists").appendingPathExtension("json")
    }
    
    func saveChecklistItems(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do{
            let jsonData = try encoder.encode(checkListItemsArray)
            try jsonData.write(to: ChecklistViewController.dataFileUrl)
        }
        catch{}
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func loadChecklistItems() -> [ChecklistItem]{
        do{
            let importedData = try Data(contentsOf: ChecklistViewController.dataFileUrl)
            return try JSONDecoder().decode([ChecklistItem].self, from: importedData)
        }catch{
            return []
        }
        
    }
    
    func getElementByInputText(inputElement: ChecklistItem)-> Int{
        for i in 0...checkListItemsArray.count-1 {
            if checkListItemsArray[i].text == inputElement.text{
                return i
            }
        }
        return -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ChecklistViewController.documentDirectory.path)
        print(ChecklistViewController.dataFileUrl.path)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return checkListItemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistItemCell
        let item = checkListItemsArray[indexPath.row]
        cell.initCell(inputCheckList: item)
        return cell
    }
    @IBAction func addDummyToDo(_ sender: Any) {
        checkListItemsArray.append(ChecklistItem(text: "Nouvel élément"))
        table.beginUpdates()
        table.insertRows(at: [
            NSIndexPath(row: checkListItemsArray.count-1, section: 0) as IndexPath], with: .automatic)
        table.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addItem"{
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! ItemDetailViewController
            destVC.delegate = self
        } else if segue.identifier == "editItem"{
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! ItemDetailViewController
            destVC.delegate = self
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            destVC.itemToEdit = checkListItemsArray[indexPath.row]
            destVC.index = indexPath.row
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            checkListItemsArray.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
            saveChecklistItems()
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.accessoryType = (item.checked) ? .checkmark : .none
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.textLabel?.text = item.text
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkListItemsArray[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension ChecklistViewController:ItemDetailViewControllerDelegate{
    func itemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
        saveChecklistItems()
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        table.beginUpdates()
        checkListItemsArray.append(ChecklistItem(text: item.text))
        table.insertRows(at: [IndexPath(row: checkListItemsArray.count-1, section: 0)], with: .automatic)
        table.endUpdates()
        dismiss(animated: true, completion: nil)
        saveChecklistItems()
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem, indexAt:Int){
        table.beginUpdates()
        checkListItemsArray[indexAt] = item
        
        table.reloadRows(at: [IndexPath(row: indexAt, section: 0)], with: .automatic)
        table.endUpdates()
        dismiss(animated: true, completion: nil)
        saveChecklistItems()
    }
}
