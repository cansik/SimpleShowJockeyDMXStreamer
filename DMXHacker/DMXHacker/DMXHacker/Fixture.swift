//
//  Fixture.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 26/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

class Fixture : NSObject
{
    var position : Int
    var data : [UInt8]
    var name : String = "Fixture"
    
    subscript(index: Int) -> UInt8 {
        get {
            return data[index]
        }
        set(newValue) {
            data[index] = newValue;
        }
    }
    
    init(position : Int, size:Int)
    {
        self.position = position;
        data = [UInt8](count:size, repeatedValue:0);
    }
    
    var color : FixtureColor {
        get {
            return FixtureColor(r: 100, g: 100, b: 100)
        }
    }
    
    override var description : String {
        get {
            return "\(name): [" + ", ".join(data.map({n in String(format: "%03d", n)})) + "]"
        }
    }

}