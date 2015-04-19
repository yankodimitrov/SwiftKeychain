//
//  KeychainQueryTests.swift
//  SwiftKeychain
//
//  Created by Yanko Dimitrov on 11/13/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import UIKit
import XCTest

class KeychainQueryTests: XCTestCase {
    
    class KeychainStub: KeychainService {
        
        let accessMode: NSString = "mode"
        let serviceName = "fake.service"
        var accessGroup: String?
        
        func add(key: KeychainItem) -> NSError? { return nil }
        func update(key: KeychainItem) -> NSError? { return nil }
        func remove(key: KeychainItem) -> NSError? { return nil }
        func get<T: BaseKey>(key: T) -> (item: T?, error: NSError?) { return (nil, nil) }
    }
    
    var fakeKeychain: KeychainStub!
    let group = "fake.group"
    
    override func setUp() {
        super.setUp()
        
        fakeKeychain = KeychainStub()
        fakeKeychain.accessGroup = group
    }
    
    func testThatWeCanCreateAnInstance() {
        
        let query = KeychainQuery(keychain: fakeKeychain)
        let fields = query.fields
        
        let accessMode = fields.objectForKey(kSecAttrAccessible) as! NSString
        let accessGroup = fields.objectForKey(kSecAttrAccessGroup) as! NSString
        
        XCTAssertEqual(accessMode, "mode", "Accessible attribute mismatch")
        XCTAssertEqual(accessGroup, group, "Access group attribute mismatch")
    }
    
    func testThatWeCanAddFieldToReturnData() {
        
        let query = KeychainQuery(keychain: fakeKeychain)
            query.shouldReturnData()
        
        let fields = query.fields
        
        let returnDataField = fields.objectForKey(kSecReturnData) as! Bool
        
        XCTAssertTrue(returnDataField, "We should be able to set the return data field to true")
    }
}
