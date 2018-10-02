//
//  ScheduleListViewController.swift
//  PregnancyDiary
//
//  Created by Hai Dang on 9/27/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class ScheduleListViewController: OriginalViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let cellHeight: CGFloat = 135.0
    var scheduleArray       = [Schedule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup UI
    
    func setupNavigationBar() {
        self.addLeftBarItem(imageName: "back", title: "")
        self.addRightBarItem(imageName: "add", imageTouch: "", title: "")
        self.customTitle(title: "Lập kế hoạch")
    }
    
    func setupUI() {
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
    
    // MARK: - Action
    
    override func tappedLeftBarButton(sender: UIButton) {
        self.popDownViewController()
    }

    override func tappedRightBarButton(sender: UIButton) {
        let newScheduleViewController = main_storyboard.instantiateViewController(withIdentifier: "NewScheduleViewController") as! NewScheduleViewController
        self.navigationController?.pushViewController(newScheduleViewController, animated: true)
    }
    
    func gotoEditSchedule(schedule: Schedule) {
        let editScheduleViewController      = main_storyboard.instantiateViewController(withIdentifier: "EditScheduleViewController") as! EditScheduleViewController
        editScheduleViewController.schedule = schedule
        self.navigationController?.pushViewController(editScheduleViewController, animated: true)
    }
    
    func deleteSchedule(schedule: Schedule) {
        self.showAlert(title: "Xác nhận", message: "Bạn chắc chắn muốn xoá nhắc nhớ này?", cancelTitle: "Huỷ", okTitle: "Đồng ý", onOKAction: {
            DatabaseManager.deleteSchedule(id: schedule.id!, context: nil, onCompletionHandler: {
                Common.cancelNotification(fireDate: Date.init(timeIntervalSince1970: schedule.time))
                self.getData()
            })
        })
    }
    
    func editScheduleView(schedule: Schedule) {
        PasswordView.showInView(onOKBlock: { password in
            // Tapped ok button
            if password == schedule.password {
                self.gotoEditSchedule(schedule: schedule)
            } else {
                self.showAlert(title: "Lỗi", message: "Mật khẩu không đúng, vui lòng kiểm tra lại", cancelTitle: "Bỏ qua", okTitle: "Tiếp tục", onOKAction: {
                    self.editScheduleView(schedule: schedule)
                })
            }
        })
    }
    
    func confirmDeleteScheduleView(schedule: Schedule) {
        PasswordView.showInView(onOKBlock: { password in
            // Tapped ok button
            if password == schedule.password {
                self.deleteSchedule(schedule: schedule)
            } else {
                self.showAlert(title: "Lỗi", message: "Mật khẩu không đúng, vui lòng kiểm tra lại", cancelTitle: "Bỏ qua", okTitle: "Tiếp tục", onOKAction: {
                    self.confirmDeleteScheduleView(schedule: schedule)
                })
            }
        })
    }
    // MARK: - Handle Data
    
    func getData() {
        scheduleArray = DatabaseManager.getAllSchedule(context: nil)
        tableView.reloadData()
    }
    
    // MARK: - UITableView Delegate, DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell") as! ScheduleTableViewCell
        
        let schedule = scheduleArray[indexPath.row]
        cell.setupCell(schedule: schedule)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedule = scheduleArray[indexPath.row]

        if (schedule.password?.count)! > 0 {
            // Has password
            self.editScheduleView(schedule: schedule)
        } else {
            // Hasn't password
            self.gotoEditSchedule(schedule: schedule)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let schedule = self.scheduleArray[indexPath.row]
            if (schedule.password?.count)! > 0 {
                // Has password
                self.confirmDeleteScheduleView(schedule: schedule)
            } else {
                // Hasn't password
                self.deleteSchedule(schedule: schedule)
            }
        }
    }
}
