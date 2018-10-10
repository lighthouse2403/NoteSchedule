//
//  UserTableViewCell.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/10/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(user: UserModel) {
      nameLabel.text        = user.name
        emailLabel.text     = user.email
        
        var durationString  = ""
        let duration        = (app_delegate.serverTimeStamp - user.lastOnline)/1000
        
        if duration > 432000 {
            // 5 days
            durationString  = Common.stringFromTimeInterval(timeInterval: user.lastOnline/1000, format: "HH:mm   dd-MM-yyyy")
        } else if duration > 86400 {
            let days        = Int(duration/86400)
            durationString  = "\(days) ngày"
        } else if duration > 3600 {
            let hour        = Int(duration/3600)
            durationString  = "\(hour) giờ"
        } else if duration > 180 {
            let minute      = Int(duration/60)
            durationString  = "\(minute) phút"
        } else {
            // Online
            durationString  = "Online"
        }
        statusLabel.text    = durationString
    }
}
