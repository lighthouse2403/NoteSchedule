//  DatePickerCustomView.swift
//  nursing
//
//  Created by ThuyPH on 6/26/17.
//  Copyright © 2017 MCLab. All rights reserved.
//

import UIKit

typealias DoneBlock = (Date)->Void

class DatePickerCustomView: UIView {
    
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bodyViewBottomContraint: NSLayoutConstraint!

    var doneBlock: DoneBlock!
    var isShowTodayButton: Bool = false {
        didSet {
            todayButton.isHidden = !isShowTodayButton
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.todayButton.isHidden = true
        self.datePicker.setValue(Common.mainColor(), forKey: "textColor")
        
        self.okButton.setTitle("Lưu", for: .normal)
        self.cancelButton.setTitle("Huỷ", for: .normal)
        self.todayButton.setTitle("Hôm nay", for: .normal)
    }
    
    @IBAction func cancelButton_clicked(_ sender: Any) {
        self.dismissView()
    }
    
    @IBAction func okButton_clicked(_ sender: Any?) {
        UIView.animate(withDuration: 0.2, animations: {
            self.bodyView.center = CGPoint.init(x: self.bodyView.center.x, y: self.frame.height + self.bodyView.frame.height/2)
        }) { (onComplete) in
            if (self.doneBlock != nil) {
                self.doneBlock(self.datePicker.date.withoutSecond())
            }
            self.removeFromSuperview()
        }
    }
    
    @IBAction func todayButton_Clicked(_ button: UIButton?) {
        // Set picker today
        self.datePicker.setDate(Date(), animated: false)
        
        // Click done button
        self.okButton_clicked(nil)
    }
    
    @IBAction func closeViewButton_clicked(_ sender: Any) {
        self.dismissView()
    }

    static func showInView(view: UIView, date: Date?, onSaveBlock: @escaping DoneBlock) {
        let datePickerView = Bundle.main.loadNibNamed("DatePickerCustomView", owner: self, options: nil)?.last as! DatePickerCustomView
        datePickerView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        datePickerView.doneBlock = onSaveBlock
        datePickerView.datePicker.locale = Locale.init(identifier: "vn")
        if (date != nil) {
            datePickerView.datePicker.setDate(Date(), animated: false)
            datePickerView.datePicker.setDate(date!, animated: false)
        } else {
            datePickerView.datePicker.setDate(Date(), animated: false)
        }
        view.addSubview(datePickerView)
        
        // Animation
        datePickerView.bodyView.center = CGPoint.init(x: datePickerView.bodyView.center.x, y: datePickerView.frame.height + datePickerView.bodyView.frame.height/2)
        UIView.animate(withDuration: 0.2, animations: {
            datePickerView.bodyView.center = CGPoint.init(x: datePickerView.bodyView.center.x, y: datePickerView.frame.height - datePickerView.bodyView.frame.height/2)
        }) { (onComplete) in
            
        }
    }
    
    class func initFromNib() -> DatePickerCustomView {
        return Bundle.main.loadNibNamed(self.className, owner: self, options: nil)?.last as! DatePickerCustomView
    }
    
    func show(onView view: UIView, selectedDate: Date?, isLimitDate: Bool = true, onCompletion: @escaping DoneBlock) {
        // Set selected date
        if let date = selectedDate {
            self.datePicker.setDate(date, animated: false)
        } else {
            self.datePicker.setDate(Date(), animated: false)
        }
        
        // Set max/min for picker
        if isLimitDate {
            if self.datePicker.minimumDate == nil {
                self.datePicker.minimumDate = self.setLimitYear(year: -50)
            }
            
            if self.datePicker.maximumDate == nil {
                self.datePicker.maximumDate = self.setLimitYear(year: 1)
            }
        }
        
        // Attach view
        
        self.frame = view.bounds
        self.doneBlock = onCompletion
        
        view.addSubview(self)
        
        // Animate show picker
        
        var frame = self.bodyView.frame
        frame.origin.y = self.bounds.height
        self.bodyView.frame = frame
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            var frame = self.bodyView.frame
            frame.origin.y = self.bounds.height - frame.height
            self.bodyView.frame = frame
            
        }) { (finished) in
            //
        }
    }
    
    
    func dismissView() {
        UIView.animate(withDuration: 0.2, animations: {
             self.bodyView.center = CGPoint.init(x: self.bodyView.center.x, y: self.frame.height + self.bodyView.frame.height/2)
        }) { (onComplete) in
            self.removeFromSuperview()
        }
    }
    
    func setLimitYear(year: Int) -> Date {
        let calendar = Calendar.current
        var dateComponent = DateComponents.init()
        dateComponent.year = year
        let date = calendar.date(byAdding: dateComponent, to: Date())
        return date!
    }
}
