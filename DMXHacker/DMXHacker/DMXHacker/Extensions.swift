//
//  Extensions.swift
//  DMXHacker
//
//  Created by Florian Bruggisser on 28/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

extension NSImage {
    class func swatchWithColor(color: NSColor, size: NSSize) -> NSImage {
        let image = NSImage(size: size)
        image.lockFocus()
        NSColor.blackColor().drawSwatchInRect(NSMakeRect(0, 0, size.width, size.height))
        color.drawSwatchInRect(NSMakeRect(1, 1, size.width - 2, size.height - 2))
        image.unlockFocus()
        return image
    }
}

extension CGFloat {
    static func fromUInt8(value : UInt8) -> CGFloat
    {
        //1.0 / 255.0 = 0.003921568627 = 0.004
        return CGFloat(0.004 * Double(value))
    }
}