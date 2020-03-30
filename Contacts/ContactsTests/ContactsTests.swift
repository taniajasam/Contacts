//
//  ContactsTests.swift
//  ContactsTests
//
//  Created by Tania Jasam on 29/03/20.
//  Copyright © 2020 Tania Jasam. All rights reserved.
//

import XCTest
@testable import Contacts

class ContactsTests: XCTestCase {
    
    var sut:ContactsViewModel!
    
    override func setUp() {
        sut = ContactsViewModel()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Contacts", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        let url = URL(string: AppConstants.API.contacts)
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockSession = URLSessionMock(data: data, response: urlResponse, error: nil)
        NetworkManager.shared.webserviceHelper.session = mockSession
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ContactsList_ParsesData() {
        let promise = expectation(description: "Status code: 200")
        
        XCTAssertEqual(sut.contactKeys.count, 0, "contacts array should be empty before the data task runs")
        weak var weakSelf = self
        
        NetworkManager.shared.getContacts { (contactResponse) in
            
            var keys = [String]()
            if let contacts = contactResponse {
                for contact in contacts {
                    let prefix = String(contact.first_name!.prefix(1).uppercased())
                    if keys.contains(prefix) {
                        weakSelf?.sut.contactsDict[prefix]!.append(contact)
                    } else {
                        weakSelf?.sut.contactsDict[prefix] = [contact]
                        keys.append(prefix)
                    }
                }
                weakSelf?.sut.contactKeys = keys.sorted()
                promise.fulfill()
            }
            
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssertEqual(sut.contactKeys.count, 6, "Didn't parse 10 items from fake response")
    }
    
}
