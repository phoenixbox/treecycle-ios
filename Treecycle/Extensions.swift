//
//  Extensions.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/22/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    class func groupUserDefaults() -> NSUserDefaults {
        return NSUserDefaults(suiteName: "group.\(Constants.bundle())")!
    }
}

