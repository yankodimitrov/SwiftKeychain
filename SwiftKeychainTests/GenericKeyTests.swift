//
//  GenericKeyTests.swift
//  SwiftKeychain
//
//  Created by Yanko Dimitrov on 11/13/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import UIKit
import XCTest

class GenericKeyTests: XCTestCase {

    let keyName = "password"
    let keyValue: NSString = "1234"
    
    func testThatWeCanMakeAnInstance() {
        
        let key = GenericKey(keyName: keyName, value: keyValue)
        
        XCTAssertEqual(keyName, key.name, "Key names should match")
    }
    
    func testThatWillReturnFieldsToLock() {
        
        let key = GenericKey(keyName: keyName, value: keyValue)
        
        let fields = key.fieldsToLock()
        
        XCTAssert(fields.count > 0, "Should return a dictionary with fields to lock/store in the Keychain")
    }
    
    func testThatWillReturnEmptyFieldsToLockOnIncomleteKeyData() {
        
        let key = GenericKey(keyName: keyName)
        
        let fields = key.fieldsToLock()
        
        XCTAssert(fields.count == 0, "Should return an empty dictionary with fields to lock on incomplete key data")
    }
    
    func testThatWillUnlockStoredInTheKeychainData() {
        
        let key = GenericKey(keyName: keyName)
        let data = keyValue.dataUsingEncoding(NSUTF8StringEncoding)
        
        key.unlockData(data!)
        
        XCTAssertEqual(keyValue, key.value!, "Should decode the data stored in the keychain")
    }
}
