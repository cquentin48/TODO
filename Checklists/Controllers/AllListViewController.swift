//
//  AllListViewController.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    @IBOutlet var tableList: UITableView!
    private var checkListArray = [Checklist]()
    
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
            destVC.checkListItemsArray = destVC.loadChecklistItems()
        }else if segue.identifier == "addCategoryItem"{
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! ListDetailViewController
            destVC.delegate = self
        }else if segue.identifier == "editCategoryItem"{
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! ListDetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            destVC.delegate = self
            destVC.itemToEdit = checkListArray[indexPath.row]
            destVC.index = indexPath.row
        }
    }
}

//MARK : - Extension
extension AllListViewController:AllItemsDelegate{
    func itemViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: String) {
        checkListArray.append(Checklist(name: item))
        tableList.insertRows(at: [IndexPath(row: checkListArray.count-1, section: 0)], with: .automatic)
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: String, indexAt: Int) {
        tableList.beginUpdates()
        checkListArray[indexAt].name = item
        tableList.reloadRows(at: [IndexPath(row: indexAt, section: 0)], with: .automatic)
        tableList.endUpdates()
        dismiss(animated: true, completion: nil)
    }
    
}

extension AllListViewController:ItemViewDelegate{
    func itemDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: [ChecklistItem]) {
        //Nothing
    }
    
    func itemDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: [ChecklistItem], indexAt: Int) {
        //Nothing
    }
    
    
}
