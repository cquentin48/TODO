
//
//  AddItemViewController.swift--.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem, indexAt: Int)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var index:Int = 0
    
    var itemToEdit: ChecklistItem?
    var delegate:AddItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStateForBarButtons()
        updateButtonBarStatus()
    }
    
    func initStateForBarButtons(){
        textInput.text = ""
        doneButton.isEnabled = false
        addDelegateForTextInput()
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
        textInput?.addTarget(self, action: #selector(AddItemViewController.updateButtonBarStatus), for: .editingChanged)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: Any) {
        if(textInput.text != ""){
            if(!isEditing){
                delegate?.addItemViewController(self, didFinishAddingItem: ChecklistItem(text: textInput.text!))
            }else{
                delegate?.addItemViewController(self, didFinishEditingItem: ChecklistItem(text: textInput.text!,checked: (itemToEdit?.checked)!), indexAt: index)
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
            self.isEditing = true
        } else {
            self.title = "Ajout d'un élément"
        }
        textInput.becomeFirstResponder()
    }
}
