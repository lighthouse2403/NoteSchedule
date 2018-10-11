//
//  NewGroupViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/4/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class NewGroupViewController: OriginalViewController {

    @IBOutlet weak var groupnameLabel: UILabel!
    @IBOutlet weak var groupNameTextField: UITextField!
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
        self.customTitle(title: "Thêm nhóm")
        self.addLeftBarItem(imageName: "back", title: "")
        self.addRightBarItem(imageName: "tick", imageTouch: "", title: "")
    }
    
    func setupUI() {
        self.addTapGesture(view: view)
        self.addKeyboardObserver()
    }
    
    // MARK: - Action
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tappedRightBarButton(sender: UIButton) {
        // Save new group
    }
}
