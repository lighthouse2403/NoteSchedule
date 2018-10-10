//
//  FavoriteUserViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/10/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class FavoriteUserViewController: OriginalViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Setup UI
    func setupNavigationBar() {
        self.customTitle(title: "Liên hệ")
        self.addRightBarItem(imageName: "add", imageTouch: "", title: "")
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
}
