//
//  ContactsViewModel.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import Foundation

class ContactsViewModel {
    
    var contactsDict = [String:[ContactsResponse]]()
    
    var contactKeys = [String]() {
        didSet {
            if let reloadBlock = self.reloadTableData {
                reloadBlock()
            }
        }
    }
    
    var reloadTableData : (() -> Void)? = nil
    
    func fetchContactList()  {
        weak var weakself = self
        
        NetworkManager.shared.getContacts { (contactResponse) in
            
            var keys = [String]()
            if let contacts = contactResponse {
                for contact in contacts {
                    let prefix = String(contact.first_name!.prefix(1).uppercased())
                    if keys.contains(prefix) {
                        weakself?.contactsDict[prefix]!.append(contact)
                    } else {
                        weakself?.contactsDict[prefix] = [contact]
                        keys.append(prefix)
                    }
                }
                weakself?.contactKeys = keys.sorted()
            }
        }
    }
    
    
}
