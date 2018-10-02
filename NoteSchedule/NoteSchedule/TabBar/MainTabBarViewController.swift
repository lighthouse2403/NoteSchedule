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
        // Pregnancy
        let scheduleListViewController = main_storyboard.instantiateViewController(withIdentifier: "ScheduleListViewController") as! ScheduleListViewController
        let tabBar1 = self.setupController(scheduleListViewController,
                                               tabName: "Thai kỳ",
                                               image: IMAGE("pregnancyBar"),
                                               selectedImage: IMAGE("pregnancyBar"))
        
        self.viewControllers = [tabBar1]
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
