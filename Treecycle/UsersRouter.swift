//
//  UsersRouter.swift
//  Treecycle
//
//  Created by Shane Rogers on 11/10/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import Foundation

import UIKit
import Alamofire

struct UsersRouter {
    enum Router: URLRequestConvertible {
        case FBLogin()
        case SessionLogin()
        
        var URLRequest: NSMutableURLRequest {
            let result: (path: String, parameters: [String: AnyObject]) = {
                switch self {
                case .FBLogin():
                    let params: [String: AnyObject] = [:]
                    return (Constants.RootURL.WebAPI.root()+"/auth/facebook", params)
                case .SessionLogin():
                    let params: [String: AnyObject] = [:]
                    return (Constants.RootURL.Server.root()+"/login", params)
                }
            }()

            let URL = NSURL(string: result.path)
            let URLRequest = NSURLRequest(URL: URL!)
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: result.parameters).0
        }
    }
}