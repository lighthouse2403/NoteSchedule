//
//  FavoriteUserViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/10/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class FavoriteUserViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var favoriteUserArray   = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.setupData()
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
    
    func setupData() {
        favoriteUserArray   = DatabaseManager.getAllUser(context: nil)
        tableView.reloadData()
    }
    
    // MARK: Action
    override func tappedRightBarButton(sender: UIButton) {
        let userListViewController = main_storyboard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        self.navigationController?.pushViewController(userListViewController, animated: true)
    }
    
    // MARK: - UITableView Delegate, Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteUserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteUserTableViewCell") as! FavoriteUserTableViewCell
        cell.setupCell(user: favoriteUserArray[indexPath.row])
        return cell
    }
}
