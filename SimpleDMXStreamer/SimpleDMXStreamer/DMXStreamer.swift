//
//  DMXStreamer.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 25/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation
import Darwin

class DMXStreamer {
    
    let bufferSize = 512
    var red,green,blue,white : UInt8
    
    init(){
        red = 0
        green  = 255
        blue = 0
        white = 255
    }
    
    func sampleDMXTest()
    {
        var c = DMXController();
        if(c.openDevice(0))
        {
            println("device opened");
            
            for(var i = 0; i < 1000; i++)
            {
                var data = [UInt8](count:bufferSize, repeatedValue:0);
                data[0] = red;
                data[1] = green;
                data[2] = blue;
                data[3] = white;
                
                println(white);
                
                c.sendDMXData(data);
                //NSThread.sleepForTimeInterval(0.5);
            }

            c.closeDevice();
            println("device closed");
        }
    }
    
    func sendSampleData(){
        println("printing sample data...")
        var io : UsbIO = UsbIO()
        io.scanShowJockeyDevices()
        println(io.getShowJockeyDeviceCount())
        
        if(io.getShowJockeyDeviceCount() > 0)
        {
            var device = io.getShowJockeyDevice(0)
            
            io.openShowJockeyDevice(device)
            
            var i = 0
            while(i < 25)
            {
                var data = [UInt8](count:bufferSize, repeatedValue:0)
                data[0] = red
                data[1] = green
                data[2] = blue
                data[3] = white
                
                let pbuffer = UnsafeMutablePointer<UInt8>.alloc(bufferSize)
                pbuffer.initialize(data[0])
                
                var result = io.sendShowJockeyDeviceBuf(device, andBuffer : pbuffer, andSize : 512)
                
                //get
                let returnBuffer = UnsafeMutablePointer<UInt8>.alloc(bufferSize)
                let size = UnsafeMutablePointer<UInt32>.alloc(1)
                
                io.getShowJockeyDeviceBuf(device, andBuffer: returnBuffer, andSize: size)
                red += 10
                i++
                
                println("Step: \(i) Red: \(red)")
            
                sleep(1)
                
            }
                
            io.closeShowJockeyDevice(device)
        }
    }
}
