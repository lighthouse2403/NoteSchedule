//
//  GroupsViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/4/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class GroupsViewController: OriginalViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup UI
    
    func setupNavigationBar() {
        self.customTitle(title: "Danh sách nhóm")
        self.addRightBarItem(imageName: "add", imageTouch: "", title: "")
    }
    
    func setupUI() {
        self.addTapGesture(view: view)
        self.addKeyboardObserver()
    }
    
    // MARK: - Action
    override func tappedRightBarButton(sender: UIButton) {
        // Add new group
        let newGroupViewController = main_storyboard.instantiateViewController(withIdentifier: "NewGroupViewController") as! NewGroupViewController
        
        self.navigationController?.pushViewController(newGroupViewController, animated: true)
    }
}
