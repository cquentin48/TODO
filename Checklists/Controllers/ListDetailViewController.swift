//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//
import Foundation
import UIKit
protocol AllItemsDelegate : class {
    func itemViewControllerDidCancel(_ controller: ListDetailViewController)
    func itemDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: String)
    func itemDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: String, indexAt: Int)
}
class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textInput: UITextField!
    @IBAction func onCancelActionButton(_ sender: Any) {
        delegate?.itemViewControllerDidCancel(self)
    }
    @IBAction func onDoneActionButton(_ sender: Any) {
        if(textInput.text != ""){
            if(itemToEdit == nil){
                delegate?.itemDetailViewController(self, didFinishAddingItem: textInput.text!)
            }else{
                delegate?.itemDetailViewController(self, didFinishEditingItem: textInput.text!, indexAt: index)
            }
            
        }else{
            
        }
    }
    
    var index:Int = 0
    
    var itemToEdit: Checklist?
    var delegate:AllItemsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit == nil){
            self.title = "Nouvelle catégorie"
        }else{
            self.title = "Edition de "+(itemToEdit?.name)!
            textInput.text = (itemToEdit?.name)!
        }
        textInput.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
}
