//
//  AuthStore.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/24/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//
import Alamofire
import SwiftyJSON
import Dollar
import Cent

class AuthStore: NSObject {
    static let sharedInstance = AuthStore()
    
    var user: User?
    var accessToken: String?
    
    //MARK: Properties
    
    private let requests: NSMutableSet
    
    //MARK: Public API
    
    override init() {
        requests = NSMutableSet()

        if let token = NSUserDefaults.standardUserDefaults().valueForKey("access_token") as? String {
            accessToken = token
        } else {
            accessToken = ""
        }
        
    }
    
    func fbLogin() -> RACSignal {
        return RACSignal.createSignal({
            (subscriber: RACSubscriber!) -> RACDisposable! in

            let request = Alamofire.request(UsersRouter.Router.FBLogin()).responseString {
                (response: Response<String, NSError>) -> Void in
                switch response.result {
                case .Success(_):
                    subscriber.sendNext(response.response)
                    subscriber.sendCompleted()
                case .Failure(let error):
                    subscriber.sendError(error)
                }
            }
            
            self.requests.addObject(request)
            
            return RACDisposable(block: {
                self.requests.removeObject(request)
            })
        })
    }
    
    func sessionLogin() -> RACSignal {
        return RACSignal.createSignal({
            (subscriber: RACSubscriber!) -> RACDisposable! in
            let extracts = self.extractParams()
            let params: [String: String] = [
                "uuid": extracts[0],
                "access_token": extracts[1]

            ]
            let requestURL = Constants.RootURL.Server.root()+"/login"
            let request = Alamofire.request(.POST, requestURL as URLStringConvertible, parameters: params, encoding: .JSON).responseObject {
                (response: Response<User, NSError>) -> Void in
                switch response.result {
                case .Success(let currentUser):
                    AuthStore.sharedInstance.user = currentUser
                    subscriber.sendNext("")
                    subscriber.sendCompleted()
                case .Failure(let error):
                    subscriber.sendError(error)
                }
            }
            
            self.requests.addObject(request)
            
            return RACDisposable(block: {
                self.requests.removeObject(request)
            })
        })
    }
    
    func extractParams() -> [String] {
        if let token = AuthStore.sharedInstance.accessToken {
            return token.componentsSeparatedByString(":")
        } else {
            let storedToken = NSUserDefaults.standardUserDefaults().objectForKey("access_token") as! String
            return storedToken.componentsSeparatedByString(":")
        }
    }
    
//    func setCurrentUser(user: Dictionary) {
//        (["photo_url": "https://scontent.xx.fbcdn.net/hprofile-xpa1/v/t1.0-1/p320x320/11169172_10207344012778185_6529401657447558748_n.jpg?oh=8dd9d05dab3aec92bc406691b0c615dc&oe=56BD3DB6",
//            "uuid": "",
//            "id": "10208080799917403",
//            "token": "CAAVG9IhuDdkBAHzbneOgOKcotvcouX5PAZCOiZCE3EUzzbWD5Nc35aqsZBzF9HBoyn9e3W7nCQcDtx0P3I2fnzZBnLpjtdgslIPaYZCLf1o8trLBakQQ97eGnTPN1WrNkOw6P9QuVhyWdviMIo3KZB2GXElHVPA53CTTdJWVda23gY3HfPOodIupbq0NKrL2PbdwL7SUmbMwZDZD",
//            "expiration": "1452423476",
//            "token_type": "bearer",
//            "access_token": "",
//            "email": "phoenixbananabox@yahoo.ie",
//            "name": "Shane Rogers"])
//        User
//    }
}
