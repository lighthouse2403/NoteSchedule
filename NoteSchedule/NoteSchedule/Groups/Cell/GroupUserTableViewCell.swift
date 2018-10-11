//
//  GroupUserTableViewCell.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class GroupUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(user: User) {
        userNameLabel.text      = user.name
        statusImageView.image   = UIImage.init(named: "offline_status")
        var durationString      = ""
        let duration            = (app_delegate.serverTimeStamp - user.lastOnline)/1000
        
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
            statusImageView.image   = UIImage.init(named: "online_status")
            durationString  = "Online"
        }
        statusLabel.text    = durationString
    }
}
