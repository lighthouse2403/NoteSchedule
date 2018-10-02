//
//  ScheduleTableViewCell.swift
//  PregnancyDiary
//
//  Created by Hai Dang on 9/27/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var isAlarmSwitch: UISwitch!
    var schedule: Schedule!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func changeAlarmStatus(_ sender: UISwitch) {
        self.schedule.isAlarm = sender.isOn
        let id = self.schedule.id ?? String(schedule.time)
        DatabaseManager.syncSchedule(scheduleDict: ["isAlarm": sender.isOn, "id": id], onCompletionHandler: {
            if sender.isOn {
                if self.schedule.time >= Date().timeStamp() {
                    let date   = Date.init(timeIntervalSince1970: self.schedule.time)
                    Common.addLocalNotification(note: self.schedule.note!, fireDate: date)
                }
            } else {
                Common.cancelNotification(fireDate: Date.init(timeIntervalSince1970: self.schedule.time))
            }
        })
    }
    
    func setupCell(schedule : Schedule) {
        self.schedule       = schedule
        noteLabel.text      = schedule.note
        noteLabel.setLineHeight(lineHeight: 1.2, lineSpacing: 1)
        dateLabel.text      = Common.stringFromTimeInterval(timeInterval: schedule.time, format: "dd-MM-yyyy")
        timeLabel.text      = Common.stringFromTimeInterval(timeInterval: schedule.time, format: "HH:mm")
        isAlarmSwitch.isOn  = schedule.isAlarm
        
        // Border UI
        dateLabel.setupBorder()
        timeLabel.customBorder(radius: timeLabel.frame.height/2, color: Common.mainColor(), width: 2)
        if (schedule.password?.count)! > 0 {
            lockImageView.isHidden = false
        } else {
            lockImageView.isHidden = true
        }
    }
}
