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
        webserviceHelper.fetchResponse(url: url, shouldCancelOtherOps: true) { (data, response, error) in
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
