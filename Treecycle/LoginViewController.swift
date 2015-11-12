//
//  LoginViewController.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/26/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
//import FBSDKLoginKit

class LoginViewController: UIViewController {
    let authStore = AuthStore.sharedInstance
    
    var viewModel:LoginViewModel = LoginViewModel()

    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
                
        let accessTokenSignal = RACObserve(authStore, keyPath: "accessToken")
        accessTokenSignal.subscribeNextAs {
            (data:AnyObject) -> () in
            print("! Expect: auth store accessToken has changed !")
//            self.viewModel.sessionLogin.execute(nil)
        }


//        .doNext { }
//        .flattenMap {}
        
//        doNext:^(id x) {
//            self.signInButton.enabled = NO;
//            self.signInFailureText.hidden = YES;
//        }]
//        flattenMap:^id(id x) {
//            return [self signInSignal];
//        }]
//        subscribeNext:^(NSNumber *signedIn) {
//            self.signInButton.enabled = YES;
//            BOOL success = [signedIn boolValue];
//            self.signInFailureText.hidden = success;
//            if (success) {
//                [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//            }
//        }];
        
        loginButton.rac_command = viewModel.fbLogin
//        viewModel.loginSignal().observe(Signal.Observer { event in
//                switch event {
//                case let .Next(next):
//                    print("Next: \(next)")
//                case let .Failed(error):
//                    print("Failed: \(error)")
//                case .Completed:
//                    print("Completed")
//                case .Interrupted:
//                    print("Interrupted")
//                }
//                })
//        viewModel.login?.executionSignals.subscribeCompleted {
//            () -> Void in
//            print("Execution completed! **")
//        }
//        viewModel.login?.executionSignals.flattenMap()
        viewModel.fbLogin?.executionSignals.subscribeNext {
            (data: AnyObject!) -> () in
            let subSignal = data as! RACSignal
            
            subSignal.subscribeNext {
                (data: AnyObject!) -> () in
                let response = data as! NSHTTPURLResponse
                
                self.performSegueWithIdentifier("oauthSegue", sender: response.URL!)
            }
            print("Execution next! **")
        }
        viewModel.sessionLogin?.executionSignals.subscribeNext {
            (data: AnyObject!) -> () in
            let subSignal = data as! RACSignal
            
            subSignal.subscribeNext {
                (data: AnyObject!) -> () in
                print("Bing Bing! **")
//                self.performSegueWithIdentifier("oauthSegue", sender: response.URL!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginCompletion(user: User?, error: NSError?) -> Void {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            let userDefaults = NSUserDefaults.groupUserDefaults()
            
            if (!userDefaults.boolForKey(Constants.General.OnboardingShown.key())) {
                appDelegate.loadOnboardingInterface()
            } else {
                appDelegate.loadMainInterface()
            }
        }

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "oauthSegue" {
            (segue.destinationViewController as! OAuthViewController).requestURL = sender as! NSURL
            (segue.destinationViewController as! OAuthViewController).viewModel = viewModel
        }
    }

}
