
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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var index:Int = 0
    
    var itemToEdit: ChecklistItem?
    var delegate:ItemDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStateForBarButtons()
        updateButtonBarStatus()
        loadRemindDate()
        initSwitchStatus()
        initTextColor()
    }
    
    func initTextColor(){
        if(!isDatePickerVisible){
            dueDateLabel.textColor = UIColor.darkGray
        }else{
            dueDateLabel.textColor = self.view.tintColor
        }
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
    
    func hideDatePicker(){
        isDatePickerVisible = false
        initTextColor()
        tableView.deleteRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
    }
    
    func showDatePicker(){
        isDatePickerVisible = true
        initTextColor()
        tableView.insertRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return (isDatePickerVisible) ? 3 : 2
        }else{
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if(indexPath.row == 1 && indexPath.section == 1){
            return indexPath
        }else{
            return nil
        }
    }
    @IBAction func dateChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY, hh:mm a"
        let date = sender as! UIDatePicker
        dueDateLabel.text = dateFormatter.string(from: date.date)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        if(indexPath.row == 1 && indexPath.section == 1){
            if(isDatePickerVisible){
                hideDatePicker()
            }else{
                showDatePicker()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if(indexPath.row == 2 && indexPath.section == 1){
            return super.tableView(tableView, indentationLevelForRowAt: IndexPath(row: 1, section: 1))
        }else{
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
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
            return datePicker.intrinsicContentSize.height+1
        }else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    @IBAction func switchStatusUpdated(_ sender: Any) {
        itemToEdit?.checked = !(shouldRemindSwitch.isOn)
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
        super.viewWillAppear(true)
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
