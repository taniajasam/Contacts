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
        static let reviews                  = "https://api.themoviedb.org/3/movie/{id}/reviews"
        static let credits                  = "https://api.themoviedb.org/3/movie/{id}/credits"
        static let posterSize               = "w342"
        
    }
    
    struct ViewIdentifiers {
        static let contactListCell        = "ContactListTableViewCell"
        static let detailView       = "DetailViewController"
        static let posterViewCell   = "PosterTableViewCell"
        static let sysnopsisCell    = "SynopsisTableViewCell"
    }
}
