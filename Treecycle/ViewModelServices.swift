//
//  ViewModelServices.swift
//  Treecycle
//
//  Created by Shane Rogers on 11/11/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import Foundation

protocol ViewModelAPI {
//    func pushViewModel(viewModel:AnyObject)
}

class ViewModelServices: ViewModelAPI {
    static let sharedInstance = ViewModelServices()
    
    var navigationController: UINavigationController?
    
    init() {
        
    }
}