//
//  UILabelExtension.swift
//  PregnancyDiary
//
//  Created by Hai Dang Nguyen on 4/16/18.
//  Copyright © 2018 Beacon. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setLineHeight(lineHeight: CGFloat = 0.0, lineSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString(string: self.text!)
        attrString.addAttribute(NSAttributedStringKey.font, value: self.font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
    
    func customText (fullText : String, changeText : String, customSize: CGFloat) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: customSize) , range: range)
        self.attributedText = attribute
    }
}
