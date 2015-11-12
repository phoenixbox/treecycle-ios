//
//  OAuthViewController.swift
//  Treecycle
//
//  Created by Shane Rogers on 11/11/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import UIKit
import SwiftyJSON

class OAuthViewController: UIViewController, UIWebViewDelegate {
    var viewModel:LoginViewModel?
    @IBOutlet weak var webView: UIWebView!
    var requestURL:NSURL!
    
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self

        // Do any additional setup after loading the view.

        let request = NSMutableURLRequest(URL: self.requestURL)
        self.webView.loadRequest(request)
    }
//    <meta name=\"viewport\" content=\"width=320\"/>

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let profilePattern = Constants.RootURL.WebAPI.root() + "/profile"
        let authPattern = Constants.RootURL.WebAPI.root() + "/auth/facebook"
        let urlString = request.URLString
//        when the request matches the /profile
        // parse the query string for the user and then pop view view controller
        if (urlString.rangeOfString(profilePattern, options: .RegularExpressionSearch) != nil) {
            let URL = NSURL(string: urlString)
            let queryParams = URL?.decodeToDict()
            let json = JSON(queryParams!)
            
            if let token = json["access_token"].string {
                AuthStore.sharedInstance.accessToken = token
                NSUserDefaults.standardUserDefaults().setObject(token, forKey: "access_token")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            
            
            viewModel?.sessionLogin.execute(nil)
//            viewModel!.accessToken = json["access_token"].string!
            
            self.navigationController?.popViewControllerAnimated(true)
            
            return false
        } else if (urlString.rangeOfString(authPattern, options: .RegularExpressionSearch) != nil) {
            let headerFields = request.allHTTPHeaderFields!
            let fields = headerFields.keys.map({$0})
            let headerIsPresent = fields.contains("Native")

            if headerIsPresent || navigationType == UIWebViewNavigationType.Other {
                return true
            } else {
                // Prevent the inital auth request and add iOS  field
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    dispatch_async(dispatch_get_main_queue(), {
                        let newRequest: NSMutableURLRequest = request as! NSMutableURLRequest
                        newRequest.addValue("iOS", forHTTPHeaderField: "Native")
                        
                        // reload the request
                        self.webView.loadRequest(newRequest)
                    })
                })
                return false
            }
        } else {
            return true
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
