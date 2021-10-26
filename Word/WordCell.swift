//
//  WordCell.swift
//  Word
//
//  Created by Zheng, Minghui on 10/25/21.
//


import UIKit

class WordCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with entry: Entry) {
         
        if let title = entry.value(forKey: "title") as? String,
            let password = entry.value(forKey: "password") as? String {
            
            titleLabel?.text = title
            passwordLabel?.text = password
            
        }
    }

}
