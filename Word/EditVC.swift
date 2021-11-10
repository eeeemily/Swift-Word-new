//
//  EditVC.swift
//  Word
//
//  Created by Zheng, Minghui on 10/25/21.
//

import UIKit
import CoreData

class EditVC: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
   @IBOutlet weak var passwordTextfield: UITextField!
    let pword = Password()
    var autoPword: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func saveItem(title: String, password: String) {
        let context = AppDelegate.cdContext
        if let entity = NSEntityDescription.entity(forEntityName: "Entry", in: context) {
            let entry = NSManagedObject(entity: entity, insertInto: context)
            entry.setValue(title, forKeyPath: "title")
            if(password.count<4){
                print("password is too short!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                invalidPasswordAlert(controller: self)
                if(autoPword.count>7){
                    print("****************************")
                    print(autoPword)
                    print("****************************")

                    entry.setValue(password, forKeyPath: "password")
                    entry.setValue(pword.testPwd(pwd: password), forKey: "strength")
                }
            }else{
                entry.setValue(password, forKeyPath: "password")
                entry.setValue(pword.testPwd(pwd: password), forKey: "strength")
            }
            
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save the entry. \(error), \(error.userInfo)")
            }
        }
    }
    
    func invalidPasswordAlert(controller: UIViewController) {
        let alertMsg = "Your password is invalid. Would you like to have an auto generated password?"
        let alert = UIAlertController(title: "Warning", message: alertMsg, preferredStyle: .actionSheet)
        
        let autoGenerateAction = UIAlertAction(title: "Auto Generate", style: .cancel, handler:  { [self] (_) in
            autoPword = pword.generatePsd()
        })
//        let changeAction = UIAlertAction(title: "Change Password", style: .default, handler: { (_) in
//            print("User click change button")
//        })
        let cancelAction = UIAlertAction(title: "Dismiss", style: .destructive)
        
        alert.addAction(autoGenerateAction)
//        alert.addAction(changeAction)
        alert.addAction(cancelAction)
        
//        alert.popoverPresentationController?.permittedArrowDirections = []
//        alert.popoverPresentationController?.sourceView = self.view
//        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
//
        present(alert, animated: true)
    }
    
    func autoGenerate(){
        
    }
    @IBAction func onCancel2(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)

    }
    
    @IBAction func onAdd2(_ sender: Any) {
        if let title = titleTextField?.text, let password = passwordTextfield?.text {
            saveItem(title: title, password: password)
        }
        presentingViewController?.dismiss(animated: true)

    }

}

