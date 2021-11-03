//
//  WordTVC.swift
//  Word
//
//  Created by Zheng, Minghui on 10/25/21.
//

import UIKit
import CoreData

class WordTVC: UITableViewController {
    var word: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        readData()
    }
    
    func deletionAlert(title: String, completion: @escaping (UIAlertAction) -> Void) {
        let alertMsg = "Are you sure you want to delete \(title)?"
        let alert = UIAlertController(title: "Warning", message: alertMsg, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return word.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell") as? WordCell else {
            fatalError("Expected WordCell")
        }
        
        if let entry = word[indexPath.row] as? Entry {
            cell.update(with: entry)
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let entry = word[indexPath.row] as? Entry, let title = entry.title {
                deletionAlert(title: title, completion: { _ in
                    self.deleteEntry(entry: entry)
                })
            }
        }
    }
    
    // MARK: - CoreData
    
    func readData() {
        let context = AppDelegate.cdContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entry")
        do {
            word = try context.fetch(fetchRequest)

        } catch let error as NSError {
            print("Could not fetch requested entry. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    func deleteEntry(entry: Entry) {
        let context = AppDelegate.cdContext
        if let _ = word.firstIndex(of: entry)  {
            context.delete(entry)
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not delete the entry. \(error), \(error.userInfo)")
            }
        }
        readData()
    }
    // MARK: - Actions
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        readData()
        tableView.reloadData()
    }
    
}
