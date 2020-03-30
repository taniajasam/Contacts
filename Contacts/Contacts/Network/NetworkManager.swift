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
    private let webserviceHelper = WebserviceHelper()
    
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
                    print("Error occured while parsing trending movies response")
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
                    print("Error occured while parsing trending movies response")
                    completion(nil)
                }
            }
        }
    }
    
    func addContactDetail(params: [String:Any], completion: @escaping (AddDetailsResponse?) -> ()) {
        
        guard let url = URL(string: AppConstants.API.addContactDetail) else {
            return
        }
        webserviceHelper.fetchResponse(url: url, method: "POST", shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let updatedContactResponse = try jsonDecoder.decode(AddDetailsResponse.self, from: data!)
                    completion(updatedContactResponse)
                } catch {
                    print("Error occured while parsing trending movies response")
                    completion(nil)
                }
            }
        }
    }
    
//    
//    func getReviews(id: String, completion: @escaping () -> ()) {
//        
//    }
//    
//    func getCast(id: String, completion: @escaping (CastResponse?) -> ()) {
//        guard let url = addQueryParams(urlString: AppConstants.API.credits.replacingOccurrences(of: "{id}", with: id), params: [URLQueryItem(name: "api_key", value: AppConstants.API.key)]) else {
//            return
//        }
//        
//        webserviceHelper.fetchResponse(url: url, shouldCancelOtherOps: false) { (data, response, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//                completion(nil)
//            } else {
//                let jsonDecoder = JSONDecoder()
//                do {
//                    let castResponse = try jsonDecoder.decode(CastResponse.self, from: data!)
//                    completion(castResponse)
//                } catch {
//                    print("Error occured while parsing trending movies response")
//                    completion(nil)
//                }
//            }
//        }
//    }
//    
//    func addQueryParams(urlString: String, params: [URLQueryItem]) -> URL? {
//        var urlComponents = URLComponents(string: urlString)
//        urlComponents?.queryItems = params
//        return urlComponents?.url
//    }
}
