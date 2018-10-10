//
//  UserModel.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/10/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    var id                  = ""
    var name                = ""
    var email               = ""
    var lastOnline          = 0.0
    
    func initUserModel(user: [String : AnyObject]) {
        if user["id"] != nil {
            id = user["id"] as! String
        }
        
        if user["name"] != nil {
            name = user["name"] as! String
        }
        
        if user["email"] != nil {
            email = user["email"] as! String
        }
        
        if user["lastOnline"] != nil {
            lastOnline = user["lastOnline"] as! Double
        }
    }
}
