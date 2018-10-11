//
//  GroupScheduleTableViewCell.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class GroupScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var lockImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(schedule: Schedule) {
        noteLabel.text      = schedule.note
        noteLabel.setLineHeight(lineHeight: 1.2, lineSpacing: 1)
        timeLabel.text      = Common.stringFromTimeInterval(timeInterval: schedule.time, format: "HH:mm  dd-MM-yyyy")
        statusSwitch.isOn   = schedule.isAlarm
        
        // Border UI
        timeLabel.setupBorder()
        timeLabel.customBorder(radius: timeLabel.frame.height/2, color: Common.mainColor(), width: 2)
        if (schedule.password?.count)! > 0 {
            lockImageView.isHidden = false
        } else {
            lockImageView.isHidden = true
        }
    }
}
