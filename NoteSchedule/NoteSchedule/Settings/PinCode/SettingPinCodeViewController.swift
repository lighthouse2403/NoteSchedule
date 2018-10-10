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
    
    @IBOutlet weak var pincodeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Setup UI
    
    func setupUI() {
    }
    
    func setupData() {
        let pinCode = UserDefaults.standard.object(forKey: "pin_code") as? String
        if (pinCode?.count)! > 0 {
            // Set up pin code
            pincodeView.subviews.forEach({view in
                if view.isKind(of: UIImageView.self) {
                    view.isHidden = false
                }
            })
        }
    }
    
    // MARK: - Action
    
    @IBAction func tapptedEnterPinCode(_ sender: UIButton) {
        if pinCode.count > 0 && 6 >= pinCode.count {
            UserDefaults.standard.set(pinCode, forKey: "pin_code")
            UserDefaults.standard.synchronize()
            self.showAlert(title: "Thành công", message: "Cài đặt pin code thành công", cancelTitle: "", okTitle: "Đóng", onOKAction: {
                self.dismissViewController()
            })
        } else {
            self.showAlert(title: "Lỗi", message: "Bạn chưa nhập pin code?", cancelTitle: "", okTitle: "Đóng", onOKAction: {
            })
        }
    }
    
    @IBAction func tappedClear(_ sender: UIButton) {
        pinCode = ""
        pincodeView.subviews.forEach({view in
            if view.isKind(of: UIImageView.self) {
                view.isHidden = true
            }
        })
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if  pinCode.count < 6 {
            let new     = sender.title(for: .normal) ?? ""
            pinCode     = "\(pinCode)\(new)"
            pincodeView.subviews.forEach({view in
                if view.tag < pinCode.count && view.isKind(of: UIImageView.self) {
                    view.isHidden = false
                }
            })
        }
    }
    
    @IBAction func tappedDismiss(_ sender: UIButton) {
        self.dismissViewController()
    }
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
