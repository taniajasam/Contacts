//
//  ContactDetailViewModel.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import Foundation

class ContactDetailViewModel {
    
    var contact : ContactsResponse?
    
    var contactDetail : ContactDetailResponse? {
        didSet {
            if let reloadBlock = self.reloadView {
                reloadBlock()
            }
        }
    }
    
    var reloadView : (() -> Void)? = nil
    
    func fetchContactDetail()  {
        weak var weakself = self
        if let contact = contact {
            if let contactID = contact.id {
                NetworkManager.shared.getContactDetail(contactID: "\(contactID)") { (contactDetailResponse) in
                    if let contactDetail = contactDetailResponse {
                        weakself?.contactDetail = contactDetail
                    }
                }
            }
        }
        
    }
    
}
