//
//  LoginViewModel.swift
//  Treecycle
//
//  Created by Shane Rogers on 11/10/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import Foundation

class LoginViewModel: NSObject {
    var authStore = AuthStore.sharedInstance
    var fbLogin: RACCommand!
    var sessionLogin: RACCommand!
    
    override init() {
        super.init()
        
        fbLogin = RACCommand() {
            (any:AnyObject!) -> RACSignal in
            return self.fbLoginSignal()
        }
        sessionLogin = RACCommand() {
            (any:AnyObject!) -> RACSignal in
            return self.sessionSignal()
        }
    }
    
    private func fbLoginSignal() -> RACSignal {
        return self.authStore.fbLogin().doNextAs {
            (data: AnyObject) -> () in
            print("FBLoginSignal Side Effects")
        }
    }
    private func sessionSignal() -> RACSignal {
        return self.authStore.sessionLogin().doNextAs {
            (data: AnyObject) -> () in
            print("sessionSignal Side Effects")
        }
    }

    // Alternatively give it the navigation power?
    //            var vmServices = ViewModelServices.sharedInstance
    //            vmServices.navigationController?.pushViewController(viewCotroller: vc, animated: true)

}
