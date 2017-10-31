//
//  String+CZ.swift
//  CZSwfitTest
//
//  Created by 程健 on 2017/10/27.
//  Copyright © 2017年 程健. All rights reserved.
//

import UIKit

extension String {

    
//    func size(withFont font:UIFont,maxSize: CGSize) -> CGFloat {
//        let statusLabelText: NSString = self as NSString
//        let  size = maxSize
//
//
//        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
//        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
//        return strSize.width
//    }
    
    
    func size(withFont font: UIFont, maxSize: CGSize) -> CGSize {
        let text = self as NSString
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let rect = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : AnyObject], context: nil)
        return rect.size
    }
}
