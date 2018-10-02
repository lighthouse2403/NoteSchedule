//
//  Common.swift
//  japanese
//
//  Created by Hai Dang Nguyen on 10/11/17.
//  Copyright © 2017 Beacon. All rights reserved.
//

import UIKit
import Photos

class Common: NSObject {

    // MARK: - COLOR
    // Custom color
    static func color(withRGB RGB: UInt) -> UIColor {
        return UIColor(red: CGFloat((RGB & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((RGB & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(RGB & 0x0000FF) / 255.0,
                       alpha: 1.0)
    }
    
    static func color(withRGB RGB: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat((RGB & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((RGB & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(RGB & 0x0000FF) / 255.0,
                       alpha: alpha)
    }
    
    // Show main color
    static func mainColor() -> UIColor {
        return self.color(withRGB: 0x47AC66)
    }
    
    // MARK: - DATE
    // Convert from Date to String of timeInterval
    static func stringFromDate(date:Date, format: String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        formatter.locale = NSLocale.system
        return formatter.string(from: date)
    }
    
    // Convert from timeInterval to String with format
    static func stringFromTimeInterval(timeInterval: Double, format: String) -> String {
        //Return when timeInterval wrong
        if timeInterval <= 0 {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale.system
        formatter.dateFormat = format
        
        //Get Date from timeInterval
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return formatter.string(from: date)
    }
    
    //Convert to birth date
    static func birthDateFromBabyWeek(days: Int) -> Date{
        let currentTimeStamp = Date().endOfDay().timeIntervalSince1970
        let birthDate = currentTimeStamp + Double(280 - days) * 86400.0
        
        return Date.init(timeIntervalSince1970: birthDate)
    }
    
    static func birthDateFromLastDate(date: Date) -> Date{
        let beginTimeStamp = date.timeIntervalSince1970
        let birthDate = beginTimeStamp + 280.0 * 86400.0
        
        return Date.init(timeIntervalSince1970: birthDate)
    }
    
    //Convert to baby week
    static func babyWeekFromLastDate(date: Date) -> Int{
        let beginTimeStamp = date.timeIntervalSince1970
        let currentTimeStamp = Date().endOfDay().timeIntervalSince1970

        return Int((currentTimeStamp - beginTimeStamp)/86400.0) + 2
    }
    
    static func babyWeekFrombirthDate(date: Date) -> Int{
        let birthDateTimeStamp = Int(date.timeIntervalSince1970/86400.0) * 86400
        let currentTimeStamp = Int(Date().endOfDay().timeIntervalSince1970/86400.0) * 86400
        
        return 280 - Int(Double(birthDateTimeStamp - currentTimeStamp)/86400.0)
    }
    
    //Convert to last day
    static func lastDateFromBabyWeek(days: Int) -> Date{
        let currentTimeStamp = Date().endOfDay().timeIntervalSince1970
        let lastDate = currentTimeStamp - Double(days) * 86400.0
        
        return Date.init(timeIntervalSince1970: lastDate)
    }
    
    static func lastDateFromBirthDate(date: Date) -> Date{
        let birthDateTimeStamp = date.timeIntervalSince1970
        
        let lastDate = birthDateTimeStamp - 280.0 * 86400.0
        
        return Date.init(timeIntervalSince1970: lastDate)
    }
    
    static func curentMonth() -> String {
        let birthDate = UserDefaults.standard.object(forKey: "birthDate")
        if birthDate != nil {
            let lastDate = Common.lastDateFromBirthDate(date: birthDate as! Date)
            let unitFlags = Set<Calendar.Component>([.day, .month, .year])
            let components = Calendar.current.dateComponents(unitFlags, from: lastDate, to: Date())
            
            return "\(components.month!) tháng \(components.day! + 1) ngày"
        }
        return ""
    }
    
    // MARK: - Appstore
    // Get local app version
    static func getAppVersion() -> String {
        if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return text
        }
        
        return ""
    }
    
    // Get appstore link
    static func getAppStoreLink(_ appId: String) -> String {
        var storeId = appId
        if !storeId.hasPrefix("id") {
            storeId = "id".appending(storeId)
        }
        
        return "itms-apps://itunes.apple.com/app/\(storeId)"
    }
    
    // Get app rate link
    static func getAppRateLink(appId: String) -> String {
        return Common.getAppStoreLink(appId).appending("?action=write-review")
    }
    
    /* Open external link from app */
    class func openExternalLink(link: String?) -> Bool {
        guard let url = URL(string: link ?? "") else {
            return false
        }
        
        if !UIApplication.shared.canOpenURL(url) {
            return false
        }
        
        UIApplication.shared.openURL(url)
        
        return true
    }
    
    // MARK: - Function
    static func getVisibleViewController() -> OriginalViewController? {
        if let navRoot = app_delegate.window?.rootViewController {
            if navRoot.isKind(of: UINavigationController().classForCoder){
                let nav = navRoot as! UINavigationController
                return ((nav.viewControllers.last)! as? OriginalViewController)!
            } else {
                return self.getTopController()
            }
        }
        return nil
    }
    
    static func isiPhoneX() -> Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && UIScreen.main.nativeBounds.size.height == 2436 {
            //Detect iPhoneX from resolution: 1125x2436
            return true
        }
        return false
    }
    
    // MARK: - CAMERA
    class func openCamera(controller: UIViewController) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            let alertController = UIAlertController(title: "Ứng dụng này muốn truy cập máy ảnh", message: "Vui lòng cho phép để truy cập máy ảnh", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Mở cài đặt", style: .cancel) { alertController in
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
            controller.present(alertController, animated: true, completion: nil)
        } else {
            let picker = UIImagePickerController()
            picker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = UIImagePickerControllerSourceType.camera
            controller.present(picker, animated: true, completion: nil)
        }
    }
    
    class func openGallary(controller: UIViewController) {
        let picker = UIImagePickerController()
        picker.delegate = controller as? UIImagePickerControllerDelegate & UINavigationControllerDelegate

        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.denied {
            let alertController = UIAlertController(title: "Ứng dụng này muốn truy cập thư viện ảnh", message: "Vui lòng cho phép để truy cập thư viện ảnh", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Mở cài đặt", style: .cancel) { alertController in
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
            controller.present(alertController, animated: true, completion: nil)
        } else if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == PHAuthorizationStatus.authorized {
                    picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                    controller.present(picker, animated: true, completion: nil)
                }
            })
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            controller.present(picker, animated: true, completion: nil)
        }
    }
    
    class func resizeImage(image: UIImage, maxSize: CGFloat) -> UIImage {
        let size = image.size
        var newHeight: CGFloat!
        var newWidth: CGFloat!
        var scale: CGFloat!
        
        if size.width < maxSize || size.height < maxSize {
            return image
        } else {
            if size.width > size.height {
                newWidth = maxSize
                scale = newWidth / size.width
                newHeight = size.height * scale
                
            } else {
                newHeight = maxSize
                scale = newHeight / size.height
                newWidth = size.width * scale
            }
        }
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func getTopController() -> OriginalViewController {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            return vc as! OriginalViewController
        }
        return OriginalViewController()
    }
    
    // MARK: - Local notification
    // Remove locaNotification
    class func cancelNotification(fireDate: Date) {
        let notificationArray = UIApplication.shared.scheduledLocalNotifications
        notificationArray?.forEach({notification in
            if notification.fireDate == fireDate {
                UIApplication.shared.cancelLocalNotification(notification)
                return
            }
        })
    }
    
    // Add new notification
    class func addLocalNotification(note: String, fireDate: Date) {
        // Cancel if notification exist
        let notificationArray = UIApplication.shared.scheduledLocalNotifications
        notificationArray?.forEach({notification in
            if notification.fireDate == fireDate {
                UIApplication.shared.cancelLocalNotification(notification)
            }
        })
        
        // Add new notification
        let notification:UILocalNotification = UILocalNotification()
        notification.alertTitle = "Nhắc nhớ"
 
        notification.alertBody  = note
        
        notification.fireDate   = fireDate
        UIApplication.shared.scheduleLocalNotification(notification)
    }
}
