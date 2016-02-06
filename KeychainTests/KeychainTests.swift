//
//  KeychainTests.swift
//  KeychainTests
//
//  Created by Yanko Dimitrov on 2/6/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import XCTest
@testable import Keychain

class KeychainTests: XCTestCase {
    
    func testErrorForStatusCode() {
        
        let keychain = Keychain()
        
        let expectedErrorCode = Int(errSecItemNotFound)
        let error = keychain.errorForStatusCode(errSecItemNotFound)
        
        XCTAssertEqual(error.code, expectedErrorCode, "Should return error with status code")
    }
    
    func testInsertItemWithAttributes() {
        
        let item = MockGenericPasswordItem(accountName: "John")
        let keychain = Keychain()
        var hasError = false
        
        do {
            
            try keychain.insertItemWithAttributes(item.attributes)
        
        } catch {
            
            hasError = true
        }
        
        XCTAssertEqual(hasError, false, "Should insert item with attributes in the Keychain")
    }
    
    func testInsertItemWithAttributesThrowsError() {
        
        let attributes = ["a": "b"]
        let keychain = Keychain()
        var hasError = false
        
        do {
            
            try keychain.insertItemWithAttributes(attributes)
            
        } catch {
            
            hasError = true
        }
        
        XCTAssertEqual(hasError, true, "Should throw error when the operation fails")
    }
}
