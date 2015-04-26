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
    
    //works great!
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
            
            //white++;
            green++;
            
            var trans = io.sendShowJockeyDeviceBuf(d, andBuffer: &data, andSize: 512);
            
            usleep(1000);
        }
        
        io.closeShowJockeyDevice(d);
    }
    
    func sampleDMXTest()
    {
        var c = DMXController();
        if(c.openDevice(0))
        {
            println("device opened");
            
            for(var i = 0; i < 5000; i++)
            {
                var data = [UInt8](count:bufferSize, repeatedValue:0);
                data[0] = red;
                data[1] = green;
                data[2] = blue;
                data[3] = white;
                
                if(white == 255)
                {
                    white = 0;
                }
                
                white++;
                
                c.sendDMXData(data);
                //NSThread.sleepForTimeInterval(0.5);
            }
            c.closeDevice();
            println("device closed");
        }
    }
    
    func fixtureTest()
    {
        var c = DMXController();
        if(c.openDevice(0))
        {
            println("device opened");
            
            var table = FixtureTable();
            var sls144 = FixtureRGB(position: 0);
            
            table.fixtures.append(sls144);
            
            for(var i = 0; i < 5000; i++)
            {
                
                if(sls144.b == 0)
                {
                    sls144.b = 255;
                }
                
                sls144.b--;
                c.sendDMXData(table.getDMXData());
            }
            c.closeDevice();
            println("device closed");
        }
    }

}
