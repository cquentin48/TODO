
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
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(true)
        initStateForBarButtons()
        updateButtonBarStatus()
    }
    
    func initStateForBarButtons(){
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
            dismiss(animated: true)
        }else{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textInput.becomeFirstResponder()
    }
}
