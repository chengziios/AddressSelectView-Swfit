//
//  UIImage+CZ.swift
//  CZSwfitTest
//
//  Created by 程健 on 2017/10/25.
//  Copyright © 2017年 程健. All rights reserved.
//

import UIKit

typealias CZAsset = UIImage.Asset

import Foundation
import UIKit

extension UIImage
{
    enum Asset : String {
        case Add_friend_icon_addgroup = "add_friend_icon_addgroup"
        case Add_friend_icon_contacts = "add_friend_icon_contacts"
        
        var image: UIImage {
            return UIImage(asset: self)
        }
    }
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}

