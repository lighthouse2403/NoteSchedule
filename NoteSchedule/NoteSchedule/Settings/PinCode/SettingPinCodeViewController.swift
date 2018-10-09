//
//  SetupPassCodeViewController.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/4/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

class SettingPinCodeViewController: OriginalViewController {

    var pinCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Setup UI
    
    func setupUI() {
    }
    
    // MARK: - Action
    
    @IBAction func tapptedEnterPinCode(_ sender: UIButton) {
        if pinCode.count > 0 && 6 >= pinCode.count {
            UserDefaults.standard.set(pinCode, forKey: "pin_code")
            UserDefaults.standard.synchronize()
            self.dismissViewController()
        } else {
            self.showAlert(title: "Cảnh báo!", message: "Bạn muốn xoá pin code?", cancelTitle: "Bỏ qua", okTitle: "Đồng ý", onOKAction: {
                UserDefaults.standard.removeObject(forKey: "pin_code")
                UserDefaults.standard.synchronize()
                self.dismissViewController()
            })
        }
    }
    
    @IBAction func tappedClear(_ sender: UIButton) {
        pinCode = ""
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
    }
    
    @IBAction func tappedDismiss(_ sender: UIButton) {
        self.dismissViewController()
    }
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
