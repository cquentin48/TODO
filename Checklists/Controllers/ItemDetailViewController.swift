
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
