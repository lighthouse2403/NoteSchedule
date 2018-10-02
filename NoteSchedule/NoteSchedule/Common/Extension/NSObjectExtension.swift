//
//  NSObjectExtension.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 5/9/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
