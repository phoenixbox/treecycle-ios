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
