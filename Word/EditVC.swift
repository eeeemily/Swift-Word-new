//
//  EditVC.swift
//  Word
//
//  Created by Zheng, Minghui on 10/25/21.
//

import UIKit
import CoreData

class EditVC: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func saveItem(title: String, password: String) {
        let context = AppDelegate.cdContext
        if let entity = NSEntityDescription.entity(forEntityName: "Item", in: context) {
            let entry = NSManagedObject(entity: entity, insertInto: context)
            entry.setValue(title, forKeyPath: "title")
            entry.setValue(password, forKeyPath: "password")
            
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save the entry. \(error), \(error.userInfo)")
            }
        }
    }
    @IBAction func onCancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }

    @IBAction func onAdd(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
}

