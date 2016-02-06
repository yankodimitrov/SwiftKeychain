//
//  GenericPasswordTypeExtensionsTests.swift
//  Keychain
//
//  Created by Yanko Dimitrov on 2/6/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import XCTest
@testable import Keychain

struct MockGenericPasswordItem: KeychainGenericPasswordType {
    
    let attributes = [String: AnyObject]()
    let accountName: String
    
    var data = [String: AnyObject]()
    
    var dataToStore: [String: AnyObject] {
        
        return ["token": "123456"]
    }
    
    init(accountName: String) {
        
        self.accountName = accountName
    }
}

class GenericPasswordTypeExtensionsTests: XCTestCase {
    
    func testDefaultSerciceName() {
        
        let item = MockGenericPasswordItem(accountName: "John")
        let expectedServiceName = "swift.keychain.service"
        
        XCTAssertEqual(item.serviceName, expectedServiceName, "Should contain the default service name")
    }
}
