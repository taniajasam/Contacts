//
//  HelperClass.swift
//  Contacts
//
//  Created by Tania Jasam on 30/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import Foundation

struct Helper {
     static func isValidEmail(_ email: String) -> Bool {
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

         let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         return emailPred.evaluate(with: email)
     }

    
    static func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
}
