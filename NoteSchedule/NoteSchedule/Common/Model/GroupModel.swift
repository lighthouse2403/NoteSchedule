//
//  GroupModel.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import Foundation

class GroupModel: NSObject {
    var id                  = ""
    var name                = ""
    var members             = [String]()
    var schedules           = [String]()
    
    func initGroupModel(group: [String : AnyObject]) {
        if group["id"] != nil {
            id = group["id"] as! String
        }
        
        if group["name"] != nil {
            name = group["name"] as! String
        }
        
        if group["members"] != nil {
            members = group["members"] as! [String]
        }
        
        if group["schedules"] != nil {
            schedules = group["schedules"] as! [String]
        }
    }
}
