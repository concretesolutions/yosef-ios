//
//  UIColor+Hexadecimal.swift
//  Yosef
//
//  Created by Guilherme Bayma on 3/5/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

extension UIColor {
    
    private static let kDynamicHexFormat = "#%06x"
    private static let kDynamicHexMask = 0x000000FF
    private static let kDynamicHexPrefix = "#"
    private static let kDynamicHexScanLocation = 1
    private static let kDynamicHexRGBFull = CGFloat(255.0)
    
    convenience init(hexadecimalString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexadecimalString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix(UIColor.kDynamicHexPrefix)) {
            scanner.scanLocation = UIColor.kDynamicHexScanLocation
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = UIColor.kDynamicHexMask
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / UIColor.kDynamicHexRGBFull
        let green = CGFloat(g) / UIColor.kDynamicHexRGBFull
        let blue  = CGFloat(b) / UIColor.kDynamicHexRGBFull
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexadecimalString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r * UIColor.kDynamicHexRGBFull) << 16 | (Int)(g * UIColor.kDynamicHexRGBFull) << 8 | (Int)(b * UIColor.kDynamicHexRGBFull) << 0
        return String(format:UIColor.kDynamicHexFormat, rgb)
    }
}
