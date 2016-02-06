//
//  Keychain.swift
//  Keychain
//
//  Created by Yanko Dimitrov on 2/6/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import Foundation

// MARK: - KeychainServiceType

public protocol KeychainServiceType {
    
    func insertItemWithAttributes(attributes: [String: AnyObject]) throws
    func removeItemWithAttributes(attributes: [String: AnyObject]) throws
    func fetchItemWithAttributes(attributes: [String: AnyObject]) throws -> [String: AnyObject]?
}

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
    
    public var serviceName: String {
        
        return "swift.keychain.service"
    }
    
    public var attributes: [String: AnyObject] {
    
        var attributes = [String: AnyObject]()
        
        attributes[String(kSecClass)] = kSecClassGenericPassword
        attributes[String(kSecAttrAccessible)] = accessMode
        attributes[String(kSecAttrService)] = serviceName
        attributes[String(kSecAttrAccount)] = accountName
        
        return attributes
    }
}
