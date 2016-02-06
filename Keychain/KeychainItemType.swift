//
//  KeychainItemType.swift
//  Keychain
//
//  Created by Yanko Dimitrov on 2/6/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import Foundation

// MARK: - KeychainItemType

public protocol KeychainItemType {
    
    var accessMode: String {get}
    var attributes: [String: AnyObject] {get}
    var data: [String: AnyObject] {get set}
    var dataToStore: [String: AnyObject] {get}
}

extension KeychainItemType {
    
    public var accessMode: String {
        
        return String(kSecAttrAccessibleWhenUnlocked)
    }
}
