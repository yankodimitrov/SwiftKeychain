//
//  KeychainItemTypeExtensionsTests.swift
//  Keychain
//
//  Created by Yanko Dimitrov on 2/6/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import XCTest
@testable import Keychain

struct MockKeychainItem: KeychainItemType {
    
    var attributes: [String: AnyObject] {
        
        return [String(kSecClass): kSecClassGenericPassword]
    }
    
    var data = [String: AnyObject]()
    
    var dataToStore: [String: AnyObject] {
        
        return ["token": "123456"]
    }
}

class KeychainItemTypeExtensionsTests: XCTestCase {
    
    func testDefaultAccessMode() {
        
        let item = MockKeychainItem()
        
        XCTAssertEqual(item.accessMode, String(kSecAttrAccessibleWhenUnlocked), "Should return the default access mode")
    }
    
    func testAttributesToSave() {
        
        let item = MockKeychainItem()
        
        let expectedSecClass = String(kSecClassGenericPassword)
        let expectedData = NSKeyedArchiver.archivedDataWithRootObject(["token": "123456"])
        
        let attriburesToSave = item.attributesToSave
        
        let secClass = attriburesToSave[String(kSecClass)] as? String ?? ""
        let secValueData = attriburesToSave[String(kSecValueData)] as? NSData ?? NSData()
        
        XCTAssertEqual(secClass, expectedSecClass, "Should contain the returned attributes")
        XCTAssertEqual(secValueData, expectedData, "Should contain the key data")
    }
}
