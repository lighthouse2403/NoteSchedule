//
//  MainTabBarViewController.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 4/4/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTabBarViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Function
    func addTabBarViewController() {
        
        // Schedule
        let scheduleListViewController  = main_storyboard.instantiateViewController(withIdentifier: "ScheduleListViewController") as! ScheduleListViewController
        let scheduleNavigationVC        = UINavigationController.init(rootViewController: scheduleListViewController)
        scheduleNavigationVC.navigationBar.barTintColor = Common.mainColor()
        let tabBar1 = self.setupController(scheduleNavigationVC,
                                               tabName: "Kế hoạch",
                                               image: IMAGE("schedule"),
                                               selectedImage: IMAGE("schedule"))
        
        // Group list
        let groupListViewController  = main_storyboard.instantiateViewController(withIdentifier: "GroupsViewController") as! GroupsViewController
        let groupNavigationVC        = UINavigationController.init(rootViewController: groupListViewController)
        groupNavigationVC.navigationBar.barTintColor = Common.mainColor()
        let tabBar2 = self.setupController(groupNavigationVC,
                                           tabName: "Nhóm",
                                           image: IMAGE("groups"),
                                           selectedImage: IMAGE("groups"))
        
        // Settings
        let settingViewController       = main_storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        let settingNavigationVC         = UINavigationController.init(rootViewController: settingViewController)
        settingNavigationVC.navigationBar.barTintColor = Common.mainColor()
        let tabBar3 = self.setupController(settingNavigationVC,
                                           tabName: "Cài đặt",
                                           image: IMAGE("settings"),
                                           selectedImage: IMAGE("settings"))
        
        self.viewControllers = [tabBar1,tabBar2,tabBar3]
    }
    
    func setupController(_ viewController: UIViewController, tabName: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let normalAttributes = [ NSAttributedStringKey.foregroundColor : UIColor.black,
                                 NSAttributedStringKey.font :UIFont.systemFont(ofSize: 12) ]
        
        let tabbarItem = UITabBarItem(title: tabName,
                                      image: image.withRenderingMode(.alwaysOriginal),
                                      selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        tabbarItem.setTitleTextAttributes(normalAttributes, for: .normal)
        tabbarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0)
        tabbarItem.titlePositionAdjustment = UIOffsetMake(0, -2)
        
        viewController.tabBarItem = tabbarItem
        return viewController
    }
}
