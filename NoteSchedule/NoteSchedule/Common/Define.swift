//
//  Define.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 3/5/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import Foundation
import UIKit

let app_delegate                = UIApplication.shared.delegate as! AppDelegate
let main_storyboard             = UIStoryboard(name: "Main", bundle: nil)
let comment_max                 = 1000
let title_max                   = 50

// MARK: - Size
let SCREEN_WIDTH                = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT               = UIScreen.main.bounds.size.height
let kBOTTOM_BAR_iPHONEX: CGFloat = 34.0
let kUUID                       = (UIDevice.current.identifierForVendor?.uuidString)!
// MARK: - Identifier
// App identifier
let APP_ID                      = "1188956958"

// Toast tag
let kIS_TOAST: Int = 243

// Admob
let kBannerAdUnitId             = "ca-app-pub-4981657393585558/2603567830"
let kInterstitialAdUnitID       = "ca-app-pub-4981657393585558/4986188592"
let kApplicationId              = "ca-app-pub-4981657393585558~3561426285"

// MARK: - Define Object

func IMAGE(_ imageName: String) -> UIImage {
    return UIImage(named: imageName) ?? UIImage()
}

//MARK: - Chat Type
let kALL_CHAT = 1
let kMY_CHAT = 2
let kHOT_CHAT = 3
let kFAVORITE_CHAT = 4
let kWEEK_CHAT = 5

//MARK: Baby Index
let weekArray = ["7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40"]

let bpdArray = ["","","","","","","21","25","29","32","36","39","43","46","50","53","56","59","62","65","68","71","73","76","78","81","83","85","87","89","90","92","93","94"]

let flArray = ["","","","","","","","14","17","20","23","25","28","31","34","36","39","42","44","47","49","52","54","56","59","61","63","65","67","68","70","71","73","74"]

let efwArray = ["0,5-2","1-3","3-5","5-7","12-15","18-25","35-50","60-80","90-110","121-171","150-212","185-261","227-319","275-387","399","478","568","679","785","913","1055","1210","1379","1559","1751","1953","2162","2377","2595","2813","3028","3236","3435","3619"]

// MARK: - Baby index
let numberOfMonthArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","30","36","42","48","54","60"]

let girlbabyIndexArray      = [("3.6","4.2","4.8","49.8","53.7","57.6"),("4.5","5.1","5.9","53.0","57.1","61.1"),("5.1","5.8","6.7","55.6","59.8","64.0"),("5.6","6.4","7.3","57.8","62.1","66.4"),("6.1","6.9","7.8","59.6","64.0","68.5"),( "6.4","7.3","8.3","61.2","65.7","70.3"),("6.7","7.6","8.7","62.7","67.3","71.9"),("7.0","7.9","9.0","64.0","68.7","73.5"),("7.3","8.2","9.3","65.3","70.1","75.0"),("7.5","8.5","9.6","66.5","71.5","76.4"),("7.7","8.7","9.9","67.7","72.8","77.8"),("7.9","8.9","10.2","68.9","74.0","79.2"),("8.1","9.2","10.4","70.0","75.2","80.5"),("8.3","9.4","10.7","71.0","76.4","81.7"),("8.5","9.6","10.9","72.0","77.5","83.0"),("8.7","9.8","11.2","73.0","78.6","84.2"),("8.8","10.0","11.4","74.0","79.7","85.4"),("9.0","10.2","11.6","74.9","80.7","86.5"),("9.2","10.4","11.9","75.8","81.7","87.6"),("9.4","10.6","12.1","76.7","82.7","88.7"),("9.6","10.9","12.4","77.5","83.7","89.8"),("9.8","11.1","12.6","78.4","84.6","90.8"),("9.9","11.3","12.8","79.2","85.5","91.9"),("10.1","11.5","13.1","80.0","86.4","92.9"),("11.2","12.7","14.5","83.6","90.7","97.7"),("12.1","13.9","15.9","87.4","95.1","102.7"),("13.1","15.0","17.3","90.9","99.0","107.2"),("14.0","16.1","18.6","94.1","102.7","111.3"),("14.8","17.2","20.0","97.1","106.2","115.2"),("15.7","18.2","21.3","99.9","109.4","118.9")]

let boybabyIndexArray   = [("3.9","4.5","5.1","51.1","52.7","54.7"),("4.9","5.6","6.3","54.7","56.4","58.4"),("5.6","6.4","7.2","57.6","59.3","61.4"),("6.2","7.0","7.9","60.0","61.7","63.9"),("6.7","7.5","8.4","61.9","63.7","65.9"),("7.1","7.9","8.9","63.6","65.4","67.6"),("7.4","8.3","9.3","65.1","66.9","69.2"),("7.7","8.6","9.6","66.5","68.3","70.6"),("7.9","8.9","10.0","67.7","69.6","72.0"),("8.2","9.2","10.3","69.0","70.9","73.3"),("8.4","9.4","10.5","70.2","72.1","74.5"),("8.6","9.6","10.8","71.3","73.3","75.7"),("8.8","9.9","11.1","72.4","74.4","76.9"),("9.0","10.1","11.3","73.4","75.5","78.0"),("9.2","10.3","11.6","74.4","76.5","79.1"),("9.4","10.5","11.8","75.4","77.5","80.2"),("9.6","10.7","12.0","76.3","78.5","81.2"),("9.7","10.9","12.3","77.2","79.5","82.3"),("9.9","11.1","12.5","78.1","80.4","83.2"),("10.1","11.3","12.7","78.9","81.3","84.2"),("10.3","11.5","13.0","79.7","82.2","85.1"),("10.5","11.8","13.2","80.5","83.0","86.0"),("10.6","12.0","13.4","81.3","83.8","86.9"),("10.8","12.2","13.7","82.1","84.6","87.8"),("11.8","13.3","15.0","85.5","88.4","91.9"),("12.7","14.3","16.3","89.1","92.2","96.1"),("13.5","15.3","17.5","92.4","95.7","99.9"),("15.2","17.3","19.9","98.4","102.1","106.7"),("16.0","18.3","21.1","101.2","105.2","110.0")]

let deviceNamesByCode: [String: String] =
                    ["i386"     : "Simulator",
                    "x86_64"    : "Simulator",
                    "iPod1,1"   : "iPod Touch",        // (Original)
                    "iPod2,1"   : "iPod Touch",        // (Second Generation)
                    "iPod3,1"   : "iPod Touch",        // (Third Generation)
                    "iPod4,1"   : "iPod Touch",        // (Fourth Generation)
                    "iPod7,1"   : "iPod Touch",        // (6th Generation)
                    "iPhone1,1" : "iPhone",            // (Original)
                    "iPhone1,2" : "iPhone",            // (3G)
                    "iPhone2,1" : "iPhone",            // (3GS)
                    "iPad1,1"   : "iPad",              // (Original)
                    "iPad2,1"   : "iPad 2",            //
                    "iPad3,1"   : "iPad",              // (3rd Generation)
                    "iPhone3,1" : "iPhone 4",          // (GSM)
                    "iPhone3,3" : "iPhone 4",          // (CDMA/Verizon/Sprint)
                    "iPhone4,1" : "iPhone 4S",         //
                    "iPhone5,1" : "iPhone 5",          // (model A1428, AT&T/Canada)
                    "iPhone5,2" : "iPhone 5",          // (model A1429, everything else)
                    "iPad3,4"   : "iPad",              // (4th Generation)
                    "iPad2,5"   : "iPad Mini",         // (Original)
                    "iPhone5,3" : "iPhone 5c",         // (model A1456, A1532 | GSM)
                    "iPhone5,4" : "iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                    "iPhone6,1" : "iPhone 5s",         // (model A1433, A1533 | GSM)
                    "iPhone6,2" : "iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                    "iPhone7,1" : "iPhone 6 Plus",     //
                    "iPhone7,2" : "iPhone 6",          //
                    "iPhone8,1" : "iPhone 6S",         //
                    "iPhone8,2" : "iPhone 6S Plus",    //
                    "iPhone8,4" : "iPhone SE",         //
                    "iPhone9,1" : "iPhone 7",          //
                    "iPhone9,3" : "iPhone 7",          //
                    "iPhone9,2" : "iPhone 7 Plus",     //
                    "iPhone9,4" : "iPhone 7 Plus",     //
                    "iPhone10,1": "iPhone 8",          // CDMA
                    "iPhone10,4": "iPhone 8",          // GSM
                    "iPhone10,2": "iPhone 8 Plus",     // CDMA
                    "iPhone10,5": "iPhone 8 Plus",     // GSM
                    "iPhone10,3": "iPhone X",          // CDMA
                    "iPhone10,6": "iPhone X",          // GSM
                    "iPad4,1"   : "iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                    "iPad4,2"   : "iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                    "iPad4,4"   : "iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                    "iPad4,5"   : "iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                    "iPad4,7"   : "iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                    "iPad6,7"   : "iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                    "iPad6,8"   : "iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                    "iPad6,3"   : "iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                    "iPad6,4"   : "iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
]
