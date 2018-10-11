//
//  GroupsViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/4/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class GroupsViewController: OriginalViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var groupArray = [GroupModel]()
    
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
    
    // MARK: - UITableView Datasource, Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell") as! GroupTableViewCell
        cell.setupCell(group: groupArray[indexPath.row])
        
        return cell
    }
}
