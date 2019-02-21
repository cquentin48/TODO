//
//  ViewController.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    var checkListItemsArray: [ChecklistItem] = []
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var checkBoxLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkListItemsArray.append(ChecklistItem(text: "IOS", checked: true))
        checkListItemsArray.append(ChecklistItem(text: "Android Studio"))
        checkListItemsArray.append(ChecklistItem(text: "Javascript", checked: true))
        checkListItemsArray.append(ChecklistItem(text: "WebServices"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return checkListItemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! ChecklistItemCell
        let item = checkListItemsArray[indexPath.row]
        cell.initCell(inputCheckList: item)
        //configureText(for: cell, withItem: item)
        //configureCheckmark(for: cell, withItem: item)
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
            let destVC = navVC.viewControllers.first as! AddItemViewController
            destVC.delegate = self
        } else if segue.identifier == "editItem"{
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! AddItemViewController
            destVC.delegate = self
            destVC.editElement = "editItem"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            checkListItemsArray.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .automatic)
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
        //tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension ChecklistViewController:AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        checkListItemsArray.append(ChecklistItem(text: item.text))
        table.beginUpdates()
        table.insertRows(at: [IndexPath(row: checkListItemsArray.count-1, section: 0)], with: .automatic)
        table.endUpdates()
        dismiss(animated: true, completion: nil)
    }
    
    
}
