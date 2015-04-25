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
        green  = 0
        blue = 0
        white = 0
    }
    
    func hackDMX()
    {
        var io = UsbIO();
        println("scan decives...");
        io.scanShowJockeyDevices();
        
        println("open first one");
        var d : showJockeyDevice! = io.getShowJockeyDevice(0);
        
        println("open device");
        io.openShowJockeyDevice(d);
        
        var data = [UInt8](count:512, repeatedValue:0);
        var buffer = [UInt8](count:512, repeatedValue:0);
        
        while(true)
        {
            data[0] = red;
            data[1] = green;
            data[2] = blue;
            data[3] = white;
            
            if(white == 255)
            {
                white = 0;
            }
            
            if(green == 255)
            {
                green = 0;
            }
            
            white++;
            green++;
            
            var trans = io.sendShowJockeyDeviceBuf(d, andBuffer: &data, andSize: 512);
            
            //var recv = io.getShowJockeyDeviceBuf(d, andBuffer: &buffer, andSize: 512);
            
            usleep(1000);
        }
        
        io.closeShowJockeyDevice(d);
    }
    
    func sampleDMXTest()
    {
        var c = DMXController();
        /*if(c.openDevice(0))
        {*/
        c.selectDevice(0);
            println("device opened");
        
        //c.getDMXData();
            for(var i = 0; i < 1000; i++)
            {
                var data = [UInt8](count:bufferSize, repeatedValue:0);
                data[0] = red;
                data[1] = green;
                data[2] = blue;
                data[3] = white;
                
                //println(data);
                
                c.sendDMXDataTest(data);
                //NSThread.sleepForTimeInterval(0.5);
            }
            c.getDMXData();
            c.closeDevice();
            println("device closed");
        //}
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
