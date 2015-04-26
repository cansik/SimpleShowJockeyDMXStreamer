//
//  FixtureRGB.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 26/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

class FixtureRGB : Fixture {
    let size = 3
    
    init(position : Int)
    {
        super.init(position: position, size: 3)
    }
    
    var r : UInt8 {
        get {
            return data[0]
        }
        set(newValue) {
            data[0] = newValue
        }
    }
    
    var g : UInt8 {
        get {
            return data[1]
        }
        set(newValue) {
            data[1] = newValue
        }
    }
    
    var b : UInt8 {
        get {
            return data[2]
        }
        set(newValue) {
            data[2] = newValue
        }
    }
}