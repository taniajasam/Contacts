//
//  WebServiceManager.swift
//  Contacts
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import Foundation

class WebserviceHelper {
    
    private let queue = OperationQueue()
    var session: ContactsURLSession = URLSession(configuration: .default)
    
    func fetchResponse(url: URL, method: String,params:[String:Any]? = nil, shouldCancelOtherOps: Bool, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        if shouldCancelOtherOps {
            queue.cancelAllOperations()
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let parameters = params, method == "POST" || method == "PUT" {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                request.httpBody = jsonData
            }
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        let fetchOperation = BlockOperation { [weak self] in
            let dataTask = self?.session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
            }
            
            dataTask?.resume()
        }
        queue.addOperation(fetchOperation)
    }
    
}
