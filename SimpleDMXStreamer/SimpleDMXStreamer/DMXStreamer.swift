//
//  DMXStreamer.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 25/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

class DMXStreamer {
    
    init(){
        
    }
    
    func sendSampleData(){
        println("printing sample data...");
        var io : UsbIO = UsbIO();
        print(io.getShowJockeyDeviceCount());
        var devices = io.getShowJockeyDevice(0);
    }
}
