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
                if contactKeys.count == 0 {
                    reloadBlock(false, "Data not available")
                }
                reloadBlock(true, nil)
            }
        }
    }
    
    var reloadTableData : ((Bool, String?) -> Void)? = nil
    
    func fetchContactList()  {
        weak var weakSelf = self
        
        NetworkManager.shared.getContacts { (contactResponse) in
            
            var keys = [String]()
            if let contacts = contactResponse {
                for contact in contacts {
                    let prefix = String(contact.first_name!.prefix(1).uppercased())
                    if keys.contains(prefix) {
                        weakSelf?.contactsDict[prefix]!.append(contact)
                    } else {
                        weakSelf?.contactsDict[prefix] = [contact]
                        keys.append(prefix)
                    }
                }
                weakSelf?.contactKeys = keys.sorted()
            } else {
                if let reloadBlock = weakSelf?.reloadTableData {
                    reloadBlock(false, "Data not available")
                }
            }
        }
    }
    
    func deleteContact(id: String) {
        weak var weakSelf = self
        NetworkManager.shared.deleteContact(contactId: id) { (isDeletedSuccesfully) in
            if isDeletedSuccesfully {
                weakSelf?.fetchContactList()
            } else {
                if let reloadBlock = weakSelf?.reloadTableData {
                    reloadBlock(isDeletedSuccesfully, "Something went wrong while deleting the contact")
                }
            }
        }
    }
    
}
