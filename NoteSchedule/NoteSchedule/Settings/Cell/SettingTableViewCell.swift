//
//  SettingTableViewCell.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/9/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(image: String, title: String) {
        iconImageView.setupBorder()
        iconImageView.image = UIImage.init(named: image)
        titleLabel.text     = title
    }

}
