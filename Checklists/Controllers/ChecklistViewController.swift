//
//  ViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

protocol ItemViewDelegate : class {
    func saveElement(to output:ChecklistItem, At elementIndex:Int, From categoryIndex: Int)
}

class ChecklistViewController: UITableViewController {
    var categorySelected: Int = 0
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var checkBoxLabel: UILabel!
    var rawInput:String?
    var delegate:ItemViewDelegate?
    var list: Checklist!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func getElementByInputText(inputElement: ChecklistItem)-> Int{
        for i in 0...ModelData.checkListArray[categorySelected].items.count-1 {
            if ModelData.checkListArray[categorySelected].items[i].text == inputElement.text{
                return i
            }
        }
        return -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ModelData.checkListArray[categorySelected].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistItemCell
        let item = ModelData.checkListArray[categorySelected].items[indexPath.row]
        cell.initCell(inputCheckList: item)
        return cell
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
            destVC.itemToEdit = ModelData.checkListArray[categorySelected].items[indexPath.row]
            destVC.index = indexPath.row
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ModelData.checkListArray[categorySelected].items.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
            ModelData.save()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ModelData.checkListArray[categorySelected].items[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension ChecklistViewController:ItemDetailViewControllerDelegate{
    func itemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        table.beginUpdates()
        ModelData.checkListArray[categorySelected].items.append(ChecklistItem(text: item.text))
        table.insertRows(at: [IndexPath(row: ModelData.checkListArray[categorySelected].items.count-1, section: 0)], with: .automatic)
        table.endUpdates()
        dismiss(animated: true, completion: nil)
        ModelData.save()
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem, indexAt:Int){
        table.beginUpdates()
        ModelData.checkListArray[categorySelected].items[indexAt] = item
        
        table.reloadRows(at: [IndexPath(row: indexAt, section: 0)], with: .automatic)
        table.endUpdates()
        dismiss(animated: true, completion: nil)
        ModelData.save()
    }
}
