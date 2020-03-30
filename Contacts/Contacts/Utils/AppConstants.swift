//
//  AppConstants.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    struct API {
       
        static let contacts             = "http://gojek-contacts-app.herokuapp.com/contacts.json"
        static let imageBasePath        = "http://gojek-contacts-app.herokuapp.com"
        static let contactDetail        = "http://gojek-contacts-app.herokuapp.com/contacts/{id}.json"
        static let addContactDetail     = "http://gojek-contacts-app.herokuapp.com/contacts.json"
        static let updateContactDetail  = "http://gojek-contacts-app.herokuapp.com/contacts/{id}.json"
        static let deleteContact        = "http://gojek-contacts-app.herokuapp.com/contacts/{id}.json"
    }
    
    struct ViewIdentifiers {
        static let contactListCell     = "ContactListTableViewCell"
        static let contactDetailView   = "ContactDetailVC"
        static let contactDetailCell   = "ContactDetailTableViewCell"
        static let modifyDetailView    = "ModifyContactDetailVC"
    }
    
    struct Heights {
        static let contactListRow       = UIDevice.current.userInterfaceIdiom == .pad ? 75 : 64
        static let contactSectionHeader = UIDevice.current.userInterfaceIdiom == .pad ? 60 : 30
        static let contactInfoRow       = UIDevice.current.userInterfaceIdiom == .pad ? 70 : 56
    }
}

enum ContactUpdateViewMode {
    case add
    case edit
}
