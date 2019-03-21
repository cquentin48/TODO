
//
//  AddItemViewController.swift--.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation
import UIKit

protocol ItemDetailViewControllerDelegate : class {
    func itemViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem, indexAt: Int)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    private var dueDate = Date()
    private var isDatePickerVisible = false
    @IBOutlet var dateCell: UITableViewCell!
    
    var index:Int = 0
    
    var itemToEdit: ChecklistItem?
    var delegate:ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStateForBarButtons()
        updateButtonBarStatus()
        loadRemindDate()
        initSwitchStatus()
    }
    
    func showDatePicker(){
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
        tableView.endUpdates()
        print("Activation du date picker")
    }
    
    func hideDatePicker(){
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
        tableView.endUpdates()
        print("Désactivation du date picker")
    }
    
    func loadRemindDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY, hh:mm a"
        dueDateLabel.text = dateFormatter.string(from: itemToEdit?.dueDate ?? Date())
    }
    
    func initStateForBarButtons(){
        textInput.text = ""
        doneButton.isEnabled = false
        addDelegateForTextInput()
    }
    
    func initSwitchStatus(){
        shouldRemindSwitch.isOn = !(itemToEdit?.checked ?? true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return (shouldRemindSwitch.isEnabled) ? 3 : 2
        }else{
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if(indexPath.row == 0 && indexPath.section == 0){
            tableView.cellForRow(at: indexPath)?.isEditing = true
        }else{
            tableView.cellForRow(at: indexPath)?.isEditing = false
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 1 && indexPath.row == 2){
            return dateCell
        }else{
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 2 && indexPath.section == 1){
            return dateCell.intrinsicContentSize.height+1
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    @IBAction func switchStatusUpdated(_ sender: Any) {
        itemToEdit?.checked = !(shouldRemindSwitch.isOn)
        if(shouldRemindSwitch.isOn){
            showDatePicker()
        }else{            
            hideDatePicker()
        }
    }
    
    @objc func updateButtonBarStatus(){
        if(textInput.text != ""){
            doneButton.isEnabled = true
        }else{
            doneButton.isEnabled = false
        }
    }
    
    func addDelegateForTextInput(){
        textInput?.delegate = self
        textInput?.addTarget(self, action: #selector(ItemDetailViewController.updateButtonBarStatus), for: .editingChanged)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        if(textInput.text != ""){
            if(itemToEdit == nil){
                delegate?.itemDetailViewController(self, didFinishAddingItem: ChecklistItem(text: textInput.text!))
            }else{
                delegate?.itemDetailViewController(self, didFinishEditingItem: ChecklistItem(text: textInput.text!,checked: (itemToEdit?.checked)!), indexAt: index)
            }

        }else{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let itemToEdit = itemToEdit {
            //Mode edition
            textInput.text = itemToEdit.text
            self.title = "Edition de l'élément"
            self.doneButton.isEnabled = true
        } else {
            self.title = "Ajout d'un élément"
        }
        textInput.becomeFirstResponder()
    }
}
