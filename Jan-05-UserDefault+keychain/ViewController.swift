//
//  ViewController.swift
//  Jan-05-UserDefault+keychain
//
//  Created by Admin on 6/1/23.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let email = "abc@gmail.com"
        let pass = "12345"
        guard let data = try? JSONEncoder().encode(pass) else { return }
        
        writeToKeyChain(data: data, account: email)
        
        readFromKeyChain(account: email)
    }
}

extension ViewController {
    func writeToKeyChain(data: Data, account: String) {
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : account,
            kSecAttrServer : "password",
            kSecValueData : data
        ] as CFDictionary
        
        SecItemAdd(query, nil)
        print("write successfully!")
    }
    
    func readFromKeyChain(account: String) {
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount : account,
            kSecAttrServer : "password",
            kSecReturnData : true,
            kSecReturnAttributes : true
        ] as CFDictionary
        
        var result : CFTypeRef?
        SecItemCopyMatching(query, &result)
        
        if let result = result as? [CFString:Any] {
            print("a")
            print(result[kSecValueData]!)
            print("b")
        }
    }
}

