//
//  RACObserve.swift
//  Treecycle
//
//  Created by Shane Rogers on 11/10/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import Foundation

// replaces the RACObserve macro
func RACObserve(target: NSObject!, keyPath: String) -> RACSignal  {
    return target.rac_valuesForKeyPath(keyPath, observer: target)
}