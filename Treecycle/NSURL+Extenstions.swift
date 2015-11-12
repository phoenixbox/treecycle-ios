//
//  NSURL+Extenstions.swift
//  Treecycle
//
//  Created by Shane Rogers on 11/11/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import Foundation

extension NSURL {
    func decodeToDict() -> Dictionary<String, String>? {
        var results = [String:String]()
        let keyValues = self.query?.componentsSeparatedByString("&")
        if keyValues?.count > 0 {
            for pair in keyValues! {
                let kv = pair.componentsSeparatedByString("=")
                if kv.count > 1 {
                    let result = kv[1].stringByReplacingOccurrencesOfString("+", withString: " ")
                    let decoded = result.stringByRemovingPercentEncoding!
                    
                    results.updateValue(decoded, forKey: kv[0])
                }
            }
            
        }
        return results
    }
}