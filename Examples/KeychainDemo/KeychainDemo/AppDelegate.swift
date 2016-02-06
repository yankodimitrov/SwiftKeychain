//
//  AppDelegate.swift
//  KeychainDemo
//
//  Created by Yanko Dimitrov on 2/6/16.
//  Copyright © 2016 Yanko Dimitrov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK: - InstagramAccount
    
    struct InstagramAccount: KeychainGenericPasswordType {
        
        let accountName: String
        let token: String
        var data = [String: AnyObject]()
        
        var dataToStore: [String: AnyObject] {
            
            return ["token": token]
        }
        
        var accessToken: String? {
            get {
                return data["token"] as? String
            }
        }
        
        init(name: String, accessToken: String = "") {
            
            accountName = name
            token = accessToken
        }
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let newAccount = InstagramAccount(name: "John", accessToken: "123456")
        
        // save / update
        
        do {
        
            try newAccount.saveInKeychain()
            
            print("> saved item in keychain")
            
        } catch {
            
            print(error)
        }
        
        // fetch
        
        var account = InstagramAccount(name: "John")
        
        do {
            
            try account.fetchFromKeychain()
            
            print("> fetched item from keychain")
            
            if let token = account.accessToken {
            
                print("name: \(account.accountName), token: \(token)")
            }
            
        } catch {
            
            print(error)
        }
        
        // remove
        
        do {
            
            try account.removeFromKeychain()
            
            print("> removed item from keychain")
            
        } catch {
            
            print(error)
        }
        
        return true
    }
}

