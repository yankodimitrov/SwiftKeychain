//
//  ViewController.swift
//  SwiftKeychain
//
//  Created by Yanko Dimitrov on 11/11/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let keychain = Keychain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        performGenericKeyDemo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - Keychain Demo
    ///////////////////////////////////////////////////////
    
    private func printGenericKey(key: GenericKey) {
        
        if let passcode = keychain.get(key).item?.value {
            
            println("\(key.name) value: [\(passcode)]")
            
        } else {
            
            println("can't find the [\(key.name)] key in the keychain")
        }
    }
    
    private func performGenericKeyDemo() {
        
        let keyName = "passcode"
        let key = GenericKey(keyName: keyName, value: "1234")
        let updateKey = GenericKey(keyName: keyName, value: "5678")
        
        printGenericKey(key)
        
        if let error = keychain.add(key) {
        
            println("error adding the passcode key")
            
        } else {
            
            println(">> added the passcode key")
        }
        
        printGenericKey(key)
        
        if let error = keychain.update(updateKey) {
            
            println("error updating the passcode key")
            
        } else {
    
            println(">> updated the passcode key")
        }
        
        printGenericKey(updateKey)
        
        if let error = keychain.remove(key) {
            
            println("error deleting the passcode key")
            
        } else {
            
            println(">> removed the passcode key from the keychain")
        }
    }
    
}
