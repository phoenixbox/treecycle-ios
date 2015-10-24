//
//  OnboardingViewController.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/22/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import UIKit
import AMWaveTransition

class OnboardingViewController: AMWaveViewController {
    
    @IBOutlet var viewArray: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.view.backgroundColor = UIColor.mainColor()
        self.view.backgroundColor = UIColor.clearColor()
        
        updateUI()
    }
    
    override func visibleCells() -> [AnyObject]! {
        return self.viewArray
    }
    
    func updateUI() {
        
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
