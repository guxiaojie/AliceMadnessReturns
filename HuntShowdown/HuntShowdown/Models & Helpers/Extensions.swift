//
//  Extensions.swift
//  HuntShowdown
//
//  Created by Guxiaojie on 2018/7/14.
//  Copyright © 2018 SageGu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)

    static let wrongAnswerBgColor = UIColor.rgba(r: 100, g: 150, b: 125, a: 0.5)
    static let rightAnswerBgColor = UIColor.rgba(r: 172, g: 92, b: 92, a: 0.5)
}

