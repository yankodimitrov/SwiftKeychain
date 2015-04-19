//
//  ArchiveKeyTests.swift
//  SwiftKeychain
//
//  Created by Yanko Dimitrov on 11/13/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import UIKit
import XCTest

class ArchiveKeyTests: XCTestCase {

    let keyName = "user"
    let userName = "Peter"
    let userAge = 39
    var user: NSDictionary {
        return ["name": userName, "age": userAge]
    }
    
    func testThatWeCanMakeAnInstance() {
        
        let key = ArchiveKey(keyName: keyName, object: user)
        
        XCTAssertEqual(keyName, key.name, "Key names should match")
    }
    
    func testThatWillReturnFieldsToLock() {
        
        let key = ArchiveKey(keyName: keyName, object: user)
        
        let fields = key.fieldsToLock()
        
        XCTAssert(fields.count > 0, "Should return a dictionary with fields to lock/store in the Keychain")
    }
    
    func testThatWillReturnEmptyFieldsToLockOnIncomleteKeyData() {
        
        let key = ArchiveKey(keyName: keyName)
        
        let fields = key.fieldsToLock()
        
        XCTAssert(fields.count == 0, "Should return an empty dictionary with fields to lock on incomplete key data")
    }
    
    func testThatWillUnlockStoredInTheKeychainData() {
        
        let key = ArchiveKey(keyName: keyName)
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        
        key.unlockData(data)
        
        let decodedUser = key.object! as! [NSObject: AnyObject]
        
        XCTAssertEqual(user, decodedUser, "Should decode the object data stored in the keychain")
    }

}
