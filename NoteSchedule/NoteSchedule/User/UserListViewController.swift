//
//  UserListViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/10/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class UserListViewController: OriginalViewController {

    @IBOutlet weak var searchBar: UISearchBar!
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
        self.addLeftBarItem(imageName: "back", title: "")
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    // MẢK: - Action
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
