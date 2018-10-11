//
//  GroupTableViewCell.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/11/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!
    @IBOutlet weak var numberOfScheduleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupCell(group: GroupModel) {
        groupNameLabel.text = group.name
        numberOfMembersLabel.text   = "\(group.members.count) thành viên"
        numberOfScheduleLabel.text  = "\(group.schedules.count) Kế hoạch"
    }
}
