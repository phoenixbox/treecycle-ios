//
//  AuthStore.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/24/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

class AuthStore: NSObject {
    
    var user: User?
    
    class var sharedInstance: AuthStore {
        //2
        struct Singleton {
            //3
            static let instance = AuthStore()
        }
        //4
        return Singleton.instance
    }
    override init() {
    }
}
