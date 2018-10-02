//
//  PasswordView.swift
//  NoteSchedule
//
//  Created by Hai Dang on 10/2/18.
//  Copyright © 2018 Hai Dang. All rights reserved.
//

import UIKit

typealias OKBlock = (String)->Void

class PasswordView: UIView {

    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bodyView: UIView!
    var okBlock: OKBlock!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bodyView.customBorder(radius: 10, color: .clear)
        okButton.setupBorder()
        textField.customBorder(radius: textField.frame.height/2, color: Common.mainColor(), width: 2)
    }
    
    @IBAction func cancelButton_clicked(_ sender: Any) {
        self.dismissView()
    }
    
    @IBAction func tappedOK(_ sender: Any?) {
        if (self.okBlock != nil) {
            let password = (self.textField.text?.count)! > 0 ? self.textField.text! : ""
            self.okBlock(password)
        }
        self.removeFromSuperview()
    }
    
    static func showInView(onOKBlock: @escaping OKBlock) {
        let passwordView = Bundle.main.loadNibNamed("PasswordView", owner: self, options: nil)?.last as! PasswordView
        passwordView.frame = CGRect.init(x: 0, y: 0, width: (app_delegate.window?.frame.width)!, height: (app_delegate.window?.frame.height)!)
        passwordView.okBlock = onOKBlock
        
        app_delegate.window?.addSubview(passwordView)
    }
    
    func dismissView() {
        self.removeFromSuperview()
    }
}
