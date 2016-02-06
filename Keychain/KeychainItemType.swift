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

extension KeychainItemType {
    
    internal var attributesToSave: [String: AnyObject] {
        
        var itemAttributes = attributes
        let archivedData = NSKeyedArchiver.archivedDataWithRootObject(dataToStore)
        
        itemAttributes[String(kSecValueData)] = archivedData
        
        return itemAttributes
    }
    
    internal func dataFromAttributes(attributes: [String: AnyObject]) -> [String: AnyObject]? {
        
        guard let valueData = attributes[String(kSecValueData)] as? NSData else { return nil }
        
        return NSKeyedUnarchiver.unarchiveObjectWithData(valueData) as? [String: AnyObject] ?? nil
    }
}

// MARK: - KeychainGenericPasswordType

public protocol KeychainGenericPasswordType: KeychainItemType {
    
    var serviceName: String {get}
    var accountName: String {get}
}

extension KeychainGenericPasswordType {
    
    var serviceName: String {
        
        return "swift.keychain.service"
    }
}
