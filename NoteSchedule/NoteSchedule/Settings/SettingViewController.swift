//
//  SettingViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/4/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class SettingViewController: OriginalViewController, UITableViewDelegate, UITableViewDataSource {

    let titleArray   = ["Thông tin người dùng","Cài đặt mật khẩu","Chia sẻ ứng dụng"]
    let imageArray   = ["user_info","pin_code","share"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
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
        self.customTitle(title: "Cài đặt")
        versionLabel.text = Common.getAppVersion()
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    // MARK: UITableView Delegate, Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell
        cell.setupCell(image: imageArray[indexPath.row], title: titleArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // Set up User information
            
            let settingUserInfoViewController = main_storyboard.instantiateViewController(withIdentifier: "SettingProfileViewController") as! SettingProfileViewController
            self.navigationController?.pushViewController(settingUserInfoViewController, animated: true)
            break
        case 1:
            // Setting pin code
            let settingPinCodeViewController = main_storyboard.instantiateViewController(withIdentifier: "SettingPinCodeViewController") as! SettingPinCodeViewController
            self.present(settingPinCodeViewController, animated: true, completion: nil)
            break
        default:
            // Share App
            Common.shareApplication(visibleViewController: self)
            break
        }
    }
}
