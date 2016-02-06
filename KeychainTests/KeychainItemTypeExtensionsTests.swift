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

class MockKeychain: KeychainServiceType {
    
    var isInsertCalled = false
    var isRemoveCalled = false
    var isFetchCalled = false
    
    func insertItemWithAttributes(attributes: [String: AnyObject]) throws {
        
        isInsertCalled = true
    }
    
    func removeItemWithAttributes(attributes: [String: AnyObject]) throws {
        
        isRemoveCalled = true
    }
    
    func fetchItemWithAttributes(attributes: [String: AnyObject]) throws -> [String: AnyObject]? {
        
        isFetchCalled = true
        
        return nil
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
    
    func testDataFromAttributes() {
        
        let item = MockKeychainItem()
        let attributes = item.attributesToSave
        var token = ""
        
        if let itemToken = item.dataFromAttributes(attributes)?["token"] as? String {
            
            token = itemToken
        }
        
        XCTAssertEqual(token, "123456", "Should return the item data dictionary")
    }
    
    func testDataFromAttributesWillReturnNilWhenThereIsNoData() {
        
        let item = MockKeychainItem()
        let attributes = ["a": "b"]
        
        let data = item.dataFromAttributes(attributes)
        
        XCTAssertNil(data, "Should return nil if there is no data")
    }
    
    func testDataFromAttributesWillReturnNilWhenDataIsNotDictionary() {
        
        let item = MockKeychainItem()
        let itemData = NSKeyedArchiver.archivedDataWithRootObject(["a"])
        let attributes = [String(kSecValueData): itemData]
        let data = item.dataFromAttributes(attributes)
        
        XCTAssertNil(data, "Should return nil if the data is not a dictionary")
    }
    
    
    func testAttributesForFetch() {
        
        let item = MockKeychainItem()
        let attributes = item.attributesForFetch
        
        let secReturnData = attributes[String(kSecReturnData)] as? Bool ?? false
        let secReturnAttributes = attributes[String(kSecReturnAttributes)] as? Bool ?? false
        
        XCTAssertEqual(secReturnData, true, "Should contain true in kSecReturnData")
        XCTAssertEqual(secReturnAttributes, true, "Should contain true in kSecReturnAttributes")
    }
    
    func testSaveInKeychain() {
        
        let keychain = MockKeychain()
        let item = MockKeychainItem()
        
        try! item.saveInKeychain(keychain)
        
        XCTAssertEqual(keychain.isInsertCalled, true, "Should call the Keychain to insert an item")
    }
}
