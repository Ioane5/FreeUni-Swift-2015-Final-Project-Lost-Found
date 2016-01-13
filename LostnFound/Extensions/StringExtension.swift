//
//  StringExtension.swift
//  Happiness
//
//  Created by გათი პეტრიაშვილი on 29-09-2015.
//  Copyright © 2015 Gati Petriashvili. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func toUIColor() -> UIColor? {
        var color = UIColor?()
        
        let hcount = self.characters.count - 1
        
        if self.hasPrefix("#") && (hcount == 6 || hcount == 8) {
            // extracting hex parts
            let postHashIndex = self.startIndex.advancedBy(1)
            let strHex = self.substringFromIndex(postHashIndex)
            
            let greenIndex = strHex.startIndex.advancedBy(2)
            let strRed = strHex.substringToIndex(greenIndex)
            
            let strGreen = strHex.substringWithRange(Range<String.Index>(start: strHex.startIndex.advancedBy(2), end: strHex.startIndex.advancedBy(4)))
            
            let alphaIndex = strHex.startIndex.advancedBy(6)
            let strBlue = strHex.substringWithRange(Range<String.Index>(start: strHex.startIndex.advancedBy(4), end: strHex.startIndex.advancedBy(6)))
            
            var strAlpha = "FF"
            if strHex.characters.count == 8 {
                strAlpha = strHex.substringFromIndex(alphaIndex)
            }
            
            // converting to ints
            var r: CUnsignedInt = 0
            var g: CUnsignedInt = 0
            var b: CUnsignedInt = 0
            var a: CUnsignedInt = 0
            
            NSScanner(string: strRed).scanHexInt(&r)
            NSScanner(string: strGreen).scanHexInt(&g)
            NSScanner(string: strBlue).scanHexInt(&b)
            NSScanner(string: strAlpha).scanHexInt(&a)
            
            // converting to cgfloats
            let red = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue = CGFloat(b) / 255.0
            let alpha = CGFloat(a) / 255.0
            
            color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        
        return color
    }
    
    func toColor() -> UIColor? {
        return toUIColor()
    }
    
    
}