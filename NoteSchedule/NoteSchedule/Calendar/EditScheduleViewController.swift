//
//  EditScheduleViewController.swift
//  PregnancyDiary
//
//  Created by Hai Dang on 10/1/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class EditScheduleViewController: OriginalViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var passwordTextfield: UITextField!
    var time: Double = Date().timeStamp()
    let datePicker = DatePickerCustomView.initFromNib()
    var schedule: Schedule!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupFirstData()
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Set up Navigation bar
    func setupNavigationBar() {
        self.addLeftBarItem(imageName: "back", title: "")
        self.addRightBarItem(imageName: "done", imageTouch: "", title: "")
        self.customTitle(title: "Sửa kế hoạch")
    }
    
    // MARK: Set up UI
    func setupUI() {
        dateButton.setupBorder()
        timeButton.setupBorder()
        noteTextView.customBorder(radius: 5, color: Common.mainColor())
        self.addTapGesture(view: view)
        self.addKeyboardObserver()
        
        // Setup date picker
        datePicker.datePicker.datePickerMode = .dateAndTime
        datePicker.datePicker.locale = Locale(identifier: "vn")
    }
    
    // MARK: Set up Data
    func setupFirstData() {
        // Set up default time
        time = schedule.time

        // Set up default date
        dateButton.setTitle(Common.stringFromTimeInterval(timeInterval: time, format: "dd-MM-yyyy"), for: .normal)
        timeButton.setTitle(Common.stringFromTimeInterval(timeInterval: time, format: "HH:mm"), for: .normal)
        
        // Setup default note
        noteTextView.text = schedule.note!
        
        // Set up default switch status
        alarmSwitch.isOn = schedule.isAlarm
    }
    
    // MARK: - Action
    override func tappedLeftBarButton(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tappedRightBarButton(sender: UIButton) {
        let password    = (passwordTextfield.text?.count)! > 0 ? passwordTextfield.text! : ""
        let note        = noteTextView.text.count > 0 ? noteTextView.text! : "Nhắc nhớ"
        let id          = schedule.id!
        let dict        = ["id": id, "time": time, "isAlarm": alarmSwitch.isOn, "note": note, "password": password] as [String : Any]
        DatabaseManager.syncSchedule(scheduleDict: dict, onCompletionHandler: {
            if self.alarmSwitch.isOn {
                if self.time >= Date().timeStamp() {
                    self.addLocalNotification()
                }
            } else {
                Common.cancelNotification(fireDate: Date().addingTimeInterval(self.schedule.time))
            }
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    @IBAction func tappedTime(_ sender: UIButton) {
        datePicker.show(onView: view, selectedDate: Date.init(timeIntervalSince1970: time), onCompletion: { (selectedDate) in
            //Update information
            self.time = selectedDate.timeIntervalSince1970
            self.updateDateTimeButton()
        })
    }
    
    @IBAction func tappedDate(_ sender: UIButton) {
        datePicker.show(onView: self.view, selectedDate: Date.init(timeIntervalSince1970: time), onCompletion: { (selectedDate) in
            //Update information
            self.time = selectedDate.timeIntervalSince1970
            self.updateDateTimeButton()
        })
    }
    
    // MARK: Function
    func updateDateTimeButton() {
        self.timeButton.setTitle(Common.stringFromTimeInterval(timeInterval: self.time, format: "HH:mm"), for: .normal)
        self.dateButton.setTitle(Common.stringFromTimeInterval(timeInterval: self.time, format: "dd-MM-yyyy"), for: .normal)
    }
    
    func addLocalNotification() {
        let note = noteTextView.text.count > 0 ? noteTextView.text! : Common.stringFromTimeInterval(timeInterval: self.time, format: "dd-MM-yyyy HH:mm")
        let date   = Date.init(timeIntervalSince1970: time.rounded())
        Common.addLocalNotification(note: note, fireDate: date)
    }
    
    // MARK: - Keyboard
    override func hideKeyboard(notification: NSNotification) {
        // Reset content offset to 0
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    override func showKeyboard(notification: NSNotification) {
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        // Update content offset
        let offset          = keyboardSize.cgSizeValue.height - (SCREEN_HEIGHT - (noteTextView.frame.origin.y + noteTextView.frame.height))
        let contentHeight   = noteTextView.frame.origin.y + noteTextView.frame.height + keyboardSize.cgSizeValue.height + 10
        if offset > 0 {
            scrollView.contentSize = CGSize.init(width: scrollView.frame.width, height: contentHeight)
            scrollView.setContentOffset(CGPoint.init(x: 0, y: offset + 10), animated: true)
        }
    }
}
