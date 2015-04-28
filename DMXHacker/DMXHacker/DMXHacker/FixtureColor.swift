//
//  FixtureColor.swift
//  DMXHacker
//
//  Created by Florian Bruggisser on 28/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation
import Cocoa

class FixtureColor {
    
    var red : UInt8 = 0
    var green : UInt8 = 0
    var blue : UInt8 = 0
    
    init()
    {
        
    }
    
    convenience init(r:UInt8, g:UInt8, b:UInt8)
    {
        self.init()
        
        red = r
        green = g
        blue = b
    }

    func getNSColor() -> NSColor
    {
        return NSColor(calibratedRed: CGFloat.fromUInt8(red), green: CGFloat.fromUInt8(green), blue: CGFloat.fromUInt8(blue), alpha: 1.0)
    }
    
    var description : String {
        get {
            return "FixtureColor: [\(red), \(green), \(blue)]"
        }
    }
    
}