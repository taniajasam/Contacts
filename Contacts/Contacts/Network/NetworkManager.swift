//
//  NetworkManager.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    let webserviceHelper = WebserviceHelper()
    
    private init() { }
    
    func getContacts(completion: @escaping ([ContactsResponse]?) -> ()) {
        
        guard let url = URL(string: AppConstants.API.contacts) else {
            return
        }
        webserviceHelper.fetchResponse(url: url, method: "GET", shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let contactsResponse = try jsonDecoder.decode([ContactsResponse].self, from: data!)
                    completion(contactsResponse)
                } catch {
                    print("Error occured while parsing")
                    completion(nil)
                }
            }
        }
    }
    
    func getContactDetail(contactID: String, completion: @escaping (ContactDetailResponse?) -> ()) {
        
        guard let url = URL(string: AppConstants.API.contactDetail.replacingOccurrences(of: "{id}", with: contactID)) else {
            return
        }
        webserviceHelper.fetchResponse(url: url, method: "GET", shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let contactDetail = try jsonDecoder.decode(ContactDetailResponse.self, from: data!)
                    completion(contactDetail)
                } catch {
                    print("Error occured while parsing")
                    completion(nil)
                }
            }
        }
    }
    
    func addContactDetail(params: [String:Any], completion: @escaping (AddDetailsResponse?) -> ()) {
        
        guard let url = URL(string: AppConstants.API.addContactDetail) else {
            return
        }
        webserviceHelper.fetchResponse(url: url, method: "POST", params: params, shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    
                    let updatedContactResponse = try jsonDecoder.decode(AddDetailsResponse.self, from: data!)
                    completion(updatedContactResponse)
                } catch {
                    print("Error occured while parsing")
                    completion(nil)
                }
            }
        }
    }
    
    func updateContactDetails(params: [String:Any], contactID: String, completion: @escaping (UpdatedContactResponse?) -> ()) {
        
        guard let url = URL(string: AppConstants.API.updateContactDetail.replacingOccurrences(of: "{id}", with: contactID)) else {
            return
        }
        webserviceHelper.fetchResponse(url: url, method: "PUT", params: params, shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let updatedContact = try jsonDecoder.decode(UpdatedContactResponse.self, from: data!)
                    completion(updatedContact)
                } catch {
                    print("Error occured while parsing")
                    completion(nil)
                }
            }
        }
    }
    
    func deleteContact(contactId: String, completion: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: AppConstants.API.deleteContact.replacingOccurrences(of: "{id}", with: contactId)) else {
            return
        }
        webserviceHelper.fetchResponse(url: url, method: "DELETE", shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(false)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    (httpResponse.statusCode == 204 || httpResponse.statusCode == 200) ? completion(true) : completion(false)
                }
            }
        }
    }
}
