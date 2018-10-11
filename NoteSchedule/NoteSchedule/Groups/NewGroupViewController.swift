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
    
    var memberArray     = [User]()
    var scheduleArray   = [Schedule]()
    
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
        groupNameTextField.customBorder(radius: groupNameTextField.frame.height/2, color: Common.mainColor())
        tableView.tableFooterView   = UIView.init(frame: CGRect.zero)
        self.addTapGesture(view: view)
    }
    
    // MARK: - Action
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tappedRightBarButton(sender: UIButton) {
        let groupName   = groupNameTextField.text ?? ""
        if groupName.count > 0 {
            // Save new group
            self.showActivityIndicator()
            app_delegate.firebaseObject.createNewGroup(name: groupName, members: memberArray.map{ $0.id! }, schedules: scheduleArray.map { $0.id! }, onCompletionHandler: {
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            self.showAlert(title: "Lỗi", message: "Bạn chưa nhập tên nhóm", cancelTitle: "Đóng", okTitle: "Bỏ qua", onOKAction: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
}
