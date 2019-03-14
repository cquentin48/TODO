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
    
    @IBOutlet weak var categoryIcon: UIImageView!
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseIcon" {
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.viewControllers.first as! IconPickerViewController
            destVC.delegate = self
        }
    }
    
    var index:Int = 0
    
    var itemToEdit: Checklist?
    var delegate:AllItemsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit == nil){
            self.title = "Nouvelle catégorie"
            itemToEdit = Checklist(name: "Nouvelle catégorie", icon: IconAsset.NoIcon)
            textInput.text = itemToEdit?.name
            categoryIcon.image = itemToEdit?.icon.image
        }else{
            self.title = "Edition de "+(itemToEdit?.name)!
            textInput.text = (itemToEdit?.name)!
            categoryIcon.image = itemToEdit?.icon.image
        }
        textInput.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
}

extension ListDetailViewController:IconToChooseDelegate{
    func cancel(_ controller : IconPickerViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func updateIcon(_ controller: IconPickerViewController, didFinishAddingItem index: Int) {
        itemToEdit?.icon = ModelData.iconListArray[index]
        categoryIcon.image = itemToEdit?.icon.image
        dismiss(animated: true, completion: nil)
    }
}
