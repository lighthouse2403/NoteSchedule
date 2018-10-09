//
//  SetupProfileViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/4/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class SettingProfileViewController: OriginalViewController {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
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
        self.customTitle(title: "Profile")
        self.addLeftBarItem(imageName: "back", title: "")
    }
    
    func setupUI() {
    }
    
    // MARK: - Action
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSaveProfile(_ sender: UIButton) {
        if (nicknameTextField.text?.count)! > 0 {
            UserDefaults.standard.set(nicknameTextField.text!, forKey: "nick_name")
            UserDefaults.standard.synchronize()
            self.navigationController?.popViewController(animated: true)
        } else {
            self.showAlert(title: "Lỗi", message: "Bạn chưa nhập nick name", cancelTitle: "", okTitle: "Đóng", onOKAction: {})
        }
    }
    
}
