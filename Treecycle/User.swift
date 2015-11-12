//
//  User.swift
//  Treecycle
//
//  Created by Shane Rogers on 10/24/15.
//  Copyright © 2015 Shane Rogers. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject, ResponseObjectSerializable {
    let id: Int!
    let access_token: String!
    let token_type: String!
    let uuid: String!
    let email: String!
    let facebook_username: String!
    let facebook_display_name: String!
    let facebook_photo_url: String!
    let facebook_token: String!
    
    required init(response: NSHTTPURLResponse, representation: AnyObject) {
        // If the serializer was to conform to the SwiftyJSON format then we could do
        // away with this specific value getters. We could use indexes via data["key"]
        let json = JSON(representation)
        
        self.id = json["id"].int
        self.access_token = json["access_token"].string
        self.token_type = json["token_type"].string
        self.uuid = json["uuid"].string
        self.email = json["email"].string
        self.facebook_username = json["name"].string
        self.facebook_display_name = json["facebook_display_name"].string
        self.facebook_photo_url = json["photo_url"].string
        self.facebook_token = json["facebook_token"].string
    }
}
