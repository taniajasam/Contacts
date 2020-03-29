//
//  AppConstants.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import Foundation

struct AppConstants {
    struct API {
       
        static let contacts           = "http://gojek-contacts-app.herokuapp.com/contacts.json"
        static let imageBasePath            = "http://gojek-contacts-app.herokuapp.com"
        static let contactDetail                  = "http://gojek-contacts-app.herokuapp.com/contacts/{id}.json"
        static let credits                  = "https://api.themoviedb.org/3/movie/{id}/credits"
        static let posterSize               = "w342"
        
    }
    
    struct ViewIdentifiers {
        static let contactListCell     = "ContactListTableViewCell"
        static let contactDetailView   = "ContactDetailVC"
        static let contactDetailCell   = "ContactDetailTableViewCell"
        static let modifyDetailView    = "ModifyContactDetailVC"
    }
}
