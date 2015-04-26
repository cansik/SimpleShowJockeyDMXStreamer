//
//  Fixture.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 26/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

class Fixture
{
    var position : Int;
    var data : [UInt8];
    
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
}