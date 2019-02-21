//
//  AllListViewController.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    @IBOutlet var tableEntryItemView: UITableView!
    private var checkListArray = [Checklist]()
    @IBOutlet weak var cell: UITableViewCell!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        checkListArray.append(Checklist(name:"Birthdays"))
        checkListArray.append(Checklist(name:"Groceries"))
        checkListArray.append(Checklist(name:"Cool Apps"))
        checkListArray.append(Checklist(name:"To Do"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (checkListArray.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItemList", for: indexPath)
        let item = checkListArray[indexPath.row].name
        cell.textLabel?.text = item
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showElement" {
            let destVC = segue.destination as! ChecklistViewController
            destVC.delegate = self
        }
    }
 

}

//MARK : - Extension
extension AllListViewController:AllItemsDelegate{
    func itemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        //Nothing
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        //Nothing
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem, indexAt: Int) {
        //Nothing
    }
    
    
}
