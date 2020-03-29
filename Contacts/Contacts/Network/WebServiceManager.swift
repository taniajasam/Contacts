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
    
    func fetchResponse(url: URL, shouldCancelOtherOps: Bool, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        if shouldCancelOtherOps {
            queue.cancelAllOperations()
        }
        
        let fetchOperation = BlockOperation {
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                completion(data, response, error)
            }
            dataTask.resume()
        }
        queue.addOperation(fetchOperation)
    }
    
}
