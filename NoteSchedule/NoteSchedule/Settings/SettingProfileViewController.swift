//
//  SetupProfileViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/4/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class SettingProfileViewController: OriginalViewController {

    @IBOutlet weak var nicknameTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
        self.setupData()
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
        saveButton.setupBorder()
        nicknameTextField.customBorder(radius: nicknameTextField.frame.height/2, color: Common.mainColor())
        emailTextField.customBorder(radius: emailTextField.frame.height/2, color: Common.mainColor())
    }
    
    func setupData() {
        let nickName    = UserDefaults.standard.object(forKey: "name") ?? ""
        let email       = UserDefaults.standard.object(forKey: "email") ?? ""
        
        nicknameTextField.text  = nickName as? String
        emailTextField.text     = email as? String
    }
    
    // MARK: - Action
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSaveProfile(_ sender: UIButton) {
        if (nicknameTextField.text?.count)! > 0 {
            let email   = emailTextField.text ?? ""
            UserDefaults.standard.set(nicknameTextField.text!, forKey: "name")
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.synchronize()
            self.navigationController?.popViewController(animated: true)
        } else {
            self.showAlert(title: "Lỗi", message: "Bạn chưa nhập nick name", cancelTitle: "", okTitle: "Đóng", onOKAction: {})
        }
    }
    
}
