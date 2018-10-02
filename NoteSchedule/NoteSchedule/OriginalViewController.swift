//
//  ViewController.swift
//  japanese
//
//  Created by Hai Dang Nguyen on 10/11/17.
//  Copyright © 2017 Beacon. All rights reserved.
//

import UIKit
import AVFoundation

class OriginalViewController: UIViewController {
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update logs
        DispatchQueue.global(qos: .background).async {
            app_delegate.firebaseObject.updateLogs(viewController: self.className)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        view.endEditing(true)
        DispatchQueue.global(qos: .background).async {
            app_delegate.firebaseObject.updateNickName(isTheFirst: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Function
    func addTapGesture(view: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addRefreshControl(tableView: UITableView) {
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = Common.mainColor()
        
        let attributes: [NSAttributedStringKey : Any] = [.foregroundColor: Common.mainColor(),
                                                         .font: UIFont.systemFont(ofSize: 12),]
        refreshControl.attributedTitle = NSAttributedString(string: "Đang tải bình luận ...", attributes: attributes)
        
    }
    
    @objc func refreshData(_ sender: Any) {
        // Fetch Data
    }
    
    func endRefresh() {
        self.refreshControl.endRefreshing()
    }
    
    //Show custom view
    func showAlert(title: String, message: String, cancelTitle: String, okTitle: String, onOKAction:@escaping () -> ()) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        if cancelTitle.count > 0 {
            alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.cancel, handler: nil))
        }
        if okTitle.count > 0 {
            alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: {_ in
                onOKAction()
            }))
        }
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(superView: UIView) {
        container.frame = superView.frame
        container.center = superView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.1)
        
        loadingView.frame = CGRect.init(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = superView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2 , y:loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        superView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func showActivityIndicator() {
        self.showActivityIndicator(superView: app_delegate.window!)
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     @param superView - remove activity indicator from this view
     */
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    /*
     Define UIColor from hex value
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func showActionSheet(titleArray: [String], onTapped: @escaping (String) -> ()) {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for title in titleArray {
            actionSheetController.addAction(UIAlertAction(title: title, style: UIAlertActionStyle.default, handler: {_ in
                onTapped(title)
            }))
        }
        
        actionSheetController.addAction(UIAlertAction(title: "Huỷ", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK: - Observe
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func showKeyboard(notification: NSNotification) {
    }
    
    @objc func hideKeyboard(notification: NSNotification) {
    }
    
    //MARK: - UINavigation Bar
    func addLeftBarItem(imageName : String, title : String) {
        let leftButton = UIButton.init(type: UIButtonType.custom)
        leftButton.isExclusiveTouch = true
        leftButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        leftButton.addTarget(self, action: #selector(tappedLeftBarButton(sender:)), for: UIControlEvents.touchUpInside)
        if title.count > 0 {
            leftButton.setTitle(title, for: UIControlState.normal)
        }
        if imageName.count > 0 {
            leftButton.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
    }
    
    func addRightBarItem(imageName : String, imageTouch: String, title : String) {
        let rightButton = UIButton.init(type: UIButtonType.custom)
        rightButton.isExclusiveTouch = true
        rightButton.addTarget(self, action: #selector(tappedRightBarButton(sender:)), for: UIControlEvents.touchUpInside)
        if title.count > 0 {
            rightButton.frame = CGRect.init(x: 0, y: 0, width: 80, height: 80)
            rightButton.setTitle(title, for: UIControlState.normal)
            rightButton.setupBorder()
        }
        if imageName.count > 0 {
            rightButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
            rightButton.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
        }
        if imageTouch.count > 0 {
            rightButton.setImage(UIImage.init(named: imageTouch), for: .selected)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton)
    }
    
    func addTitleNavigation(title : String) {
        var widthValue = SCREEN_WIDTH - 120
        
        if self.navigationItem.rightBarButtonItem != nil && self.navigationItem.leftBarButtonItem != nil {
            widthValue = SCREEN_WIDTH - ((self.navigationItem.rightBarButtonItem?.customView?.frame.width)! + (self.navigationItem.leftBarButtonItem?.customView?.frame.width)!) - 100
        }
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: widthValue, height: 44))
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.numberOfLines = 2

        self.navigationItem.titleView = titleLabel
    }
    
    func addButtonTitle(title : String) {
        let titleButton = UIButton.init(type: .custom)
        titleButton.isExclusiveTouch = true
        titleButton.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH - 120, height: 44)
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        titleButton.titleLabel?.numberOfLines = 2
        titleButton.setTitle(title, for: .normal)
        titleButton.addTarget(self, action: #selector(tappedTitleButton), for: .touchUpInside)
        self.navigationItem.titleView = titleButton
    }
    
    func customTitle(title: String) {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 24)
        ]
        self.title = title
    }
    
    func pushUpViewController(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func popDownViewController() -> Void {
        self.view.endEditing(true)
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromBottom;
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
    }
    
    //MARK: - Action
    @objc func tappedLeftBarButton(sender : UIButton) {
        
    }
    
    @objc func tappedRightBarButton(sender : UIButton) {
        
    }
    
    @objc func tappedTitleButton() {
        
    }
}

