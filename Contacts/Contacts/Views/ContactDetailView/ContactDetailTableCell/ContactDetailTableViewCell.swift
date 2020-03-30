//
//  ContactDetailTableViewCell.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import UIKit


class ContactDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var keyLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ContactDetailTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        valueTextField.resignFirstResponder()
        return true
    }
    
   
}
