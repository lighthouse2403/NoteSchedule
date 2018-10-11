//
//  FavoriteUserTableViewCell.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class FavoriteUserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(user: User) {
        nameLabel.text          = user.name
        emailLabel.text         = user.email
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
