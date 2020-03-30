//
//  ModifyContactViewModel.swift
//  Contacts
//
//  Created by Tania Jasam on 30/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import Foundation

class ModifyContactDetailViewModel {
    
    var contact: ContactDetailResponse?
    
    var addedContactResponse: AddDetailsResponse? {
        didSet {
            if let reloadBlock = self.reloadView {
                reloadBlock(true)
            }
        }
    }
    
    var updatedContactResponse: UpdatedContactResponse? {
           didSet {
               if let reloadBlock = self.reloadView {
                   reloadBlock(true)
               }
           }
       }
    
    var reloadView : ((Bool) -> Void)? = nil

    func addContactDetail(params: [String:Any])  {
        weak var weakself = self
        NetworkManager.shared.addContactDetail(params: params) { (updatedContactResponse) in
            if let updatedContact = updatedContactResponse {
                weakself?.addedContactResponse = updatedContact
            } else {
                if let reloadBlock = weakself?.reloadView {
                    reloadBlock(false)
                }
            }
        }
        
    }
    
    func updateContactDetail(params: [String:Any])  {
        weak var weakself = self
        NetworkManager.shared.updateContactDetails(params: params, contactID: "\(contact?.id ?? 0)", completion: { (updatedContactResponse) in
            if let updatedContact = updatedContactResponse {
                weakself?.updatedContactResponse = updatedContact
            } else {
                if let reloadBlock = weakself?.reloadView {
                    reloadBlock(false)
                }
            }
        })
        
    }
}
