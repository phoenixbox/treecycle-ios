//
//  AppDelegate.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/22/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import UIKit
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let StripePublishableKey = "pk_test_wb9VmhiWW2nSZLP7v7fAmmzk";
    // Find this at https://dashboard.stripe.com/account/apikeys
    static let stripePublishableKey = ""
    // To set this up, see https://stripe.com/docs/mobile/apple-pay
    static let appleMerchantId = ""

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
       Stripe.setDefaultPublishableKey(Constants.stripePublishableKey())
        let authStore = AuthStore.sharedInstance
        let userDefaults = NSUserDefaults.groupUserDefaults()
        
        guard let _ = authStore.user as User? else {
            loadLoginInterface()
            return true
        }
        
        if (!userDefaults.boolForKey(Constants.General.OnboardingShown.key())) {
            loadOnboardingInterface()
        } else {
            loadMainInterface()
        }

        return true
    }
    // Compose the dynamic loading of these Storyboards
    
    func loadOnboardingInterface() {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() {
            self.window?.rootViewController = controller
        }
    }
    
    func loadLoginInterface() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() {
            self.window?.rootViewController = controller
        }
    }
    
    func loadMainInterface() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateInitialViewController() {
            self.window?.rootViewController = controller
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

