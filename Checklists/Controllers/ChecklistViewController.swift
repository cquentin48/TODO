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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkListItemsArray.append(ChecklistItem(text: "IOS"))
        checkListItemsArray.append(ChecklistItem(text: "Android Studio",checked: true))
        checkListItemsArray.append(ChecklistItem(text: "Javascript",checked: true))
        checkListItemsArray.append(ChecklistItem(text: "WebServices"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return checkListItemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = checkListItemsArray[indexPath.row]
        configureText(for: cell, withItem: item)
        configureCheckmark(for: cell, withItem: item)
        //cell.accessoryType = (item.checked) ? .checkmark : .none
        return cell
    }
    @IBAction func addDummyToDo(_ sender: Any) {
        checkListItemsArray.append(ChecklistItem(text: "Nouvel élément"))
        table.beginUpdates()
        table.insertRows(at: [
            NSIndexPath(row: checkListItemsArray.count-1, section: 0) as IndexPath], with: .automatic)
        table.endUpdates()
        //table.insertRows(at: NSIndexPath(row: checkListItemsArray.count-1, section: 0), with: .automatic)
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

