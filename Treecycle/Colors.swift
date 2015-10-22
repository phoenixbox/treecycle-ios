//
//  Colors.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/22/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import UIKit

typealias Palette = UIColor
extension Palette {
    class func mainColor() -> UIColor {
        return UIColor(red:0.09, green:0.55, blue:0.17, alpha:1)
    }
    
    class func confirmColor() -> UIColor {
        return UIColor(red:0.6, green:0.8, blue:0.37, alpha:1)
    }
    
    class func destructiveColor() -> UIColor {
        return UIColor(red:0.75, green:0.22, blue:0.17, alpha:1)
    }
    
    class func lightGray() -> UIColor {
        return UIColor(red:0.91, green:0.91, blue:0.92, alpha:1)
    }
}
