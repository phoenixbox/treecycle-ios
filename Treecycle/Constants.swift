//
//  Constants.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/22/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import Foundation

public class Constants {
    public class func bundle() -> String {
        return "REPL.Treecycle"
    }
    
    public class func stripePublishableKey() -> String {
        // If debug use one if prod use another
        return "pk_test_wb9VmhiWW2nSZLP7v7fAmmzk"
    }
    
    public enum RootURL: Int {
        case Server
        case WebAPI
        
        public func root() -> String {
            switch self {
            case .Server:
                #if DEBUG
                    return "http://localhost:8000/v1"
                #else
                    return "https://treecycle-server.herokuapp.com"
                #endif
            case .WebAPI:
                #if DEBUG
                    return "http://localhost:3800"
                #else
                    return "https://treecycle.herokuapp.com"
                #endif
            }
        }
    }
    
    public enum General: Int {
        case OnboardingShown
        
        public func key() -> String {
            switch self {
            case .OnboardingShown:
                return "ONBOARDING_SHOWN"
            }
        }
    }
}
