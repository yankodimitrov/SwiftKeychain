//
//  KeychainTests.swift
//  SwiftKeychain
//
//  Created by Yanko Dimitrov on 11/11/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import UIKit
import XCTest

class KeychainTests: XCTestCase {
    
    let serviceName = "swift.keychain.tests"
    var keychain: Keychain!
    let keyName = "password"
    var key: GenericKey!
    
    override func setUp() {
        super.setUp()
        
        keychain = Keychain(serviceName: serviceName)
        key = GenericKey(keyName: keyName, value: "1234")
    }
    
    override func tearDown() {
        super.tearDown()
        
        keychain.remove(key)
    }
    
    func testSingletonInstance() {
        
        let instanceA = Keychain.sharedKeychain
        let instanceB = Keychain.sharedKeychain
        
        XCTAssert(instanceA === instanceB, "Two shared instances should point to the same address")
    }
    
    func testThatWeCanAddNewItem() {
        
        let error = keychain.add(key)
        
        XCTAssertNil(error, "Can't add a new item to the keychain")
    }
    
    func testWillFailToAddDuplicateItem() {
        
        keychain.add(key)
        
        let error = keychain.add(key)
        
        XCTAssertNotNil(error, "Should fail when attempting to add a duplicate item in the keychain")
    }
    
    func testWillFailToAddItemWithIncompleteData() {
        
        let incompleteKey = GenericKey(keyName: keyName)
        
        let error = keychain.add(incompleteKey)
        
        XCTAssertNotNil(error, "Should fail to add item with incomplete data")
    }
    
    func testThatWeCanDeleteItem() {
        
        keychain.add(key)
        let error = keychain.remove(key)
        
        XCTAssertNil(error, "Can't remove an item from the keychain")
    }
    
    func testWillFailToDeleteNonExistingItem() {
        
        let error = keychain.remove(key)
        
        XCTAssertNotNil(error, "Should fail when attempting to delete a non existing item from the keychain")
    }
    
    func testThatWeCanUpdateItem() {
        
        keychain.add(key)
        
        let newKey = GenericKey(keyName: keyName, value: "5678")
        let error = keychain.update(newKey)
        
        XCTAssertNil(error, "Can't update the item in the keychain")
    }
    
    func testThatTheUpdatedItemHasBeenUpdated() {
        
        keychain.add(key)
        
        let newSecret = "5678"
        let newKey = GenericKey(keyName: keyName, value: newSecret)
        
        keychain.update(newKey)
        
        let storedKey = keychain.get(key).item?.value
        
        XCTAssertEqual(String(storedKey!), newSecret, "Failed to update the item value")
    }
    
    func testWillFailToUpdateItemWithIncompleteData() {
        
        let incompleteKey = GenericKey(keyName: keyName)
        
        let error = keychain.add(incompleteKey)
        
        XCTAssertNotNil(error, "Should fail to update item with incomplete data")
    }
    
    func testThatWeCanGetItem() {
        
        keychain.add(key)
        
        let storedKey = keychain.get(key).item
        
        XCTAssertNotNil(storedKey, "Can't get an item from the keychain")
    }
    
    func testWillFailToGetANonExistingItem() {
        
        let error = keychain.get(key).error
        
        XCTAssertNotNil(error, "Should fail when attempting to get a non exising item from the keychain")
    }
}
