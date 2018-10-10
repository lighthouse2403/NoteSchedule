//
//  UserListViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/10/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class UserListViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTextField: TextField!
    @IBOutlet weak var tableView: UITableView!
    var userArray = [UserModel]()
    
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
        self.addLeftBarItem(imageName: "back", title: "")
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        searchTextField.customBorder(radius: searchTextField.frame.height/2, color: Common.mainColor())
    }
    
    // MARK: - Action
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSearch(_ sender: UIButton) {

        let searchString = searchTextField.text ?? ""
        if searchString.count > 0 {
            self.showActivityIndicator()
            app_delegate.firebaseObject.getUser(max: 100000, onCompletionHandler: {
                self.userArray = app_delegate.userArray.filter{$0.name.lowercased().contains(searchString.lowercased()) || $0.email.lowercased().contains(searchString.lowercased())}
                self.tableView.reloadData()
                self.hideActivityIndicator()
            })
        } else {
            self.showAlert(title: "Lỗi", message: "Vui lòng nhập tên hoặc email", cancelTitle: "", okTitle: "Đóng", onOKAction: {
                
            })
        }
    }
    
    // MARK: - UITableView delegate, datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.setupCell(user: userArray[indexPath.row])
        return cell
    }
}
