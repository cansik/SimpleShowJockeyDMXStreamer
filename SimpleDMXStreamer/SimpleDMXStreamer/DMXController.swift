//
//  DMXController.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 25/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

class DMXController
{
    let io : UsbIO = UsbIO();
    let bufferSize : Int = 512
    var currentDevice : showJockeyDevice;
    
    init()
    {
        currentDevice = showJockeyDevice();
    }
    
    func openDevice(deviceId:UInt8) -> Bool
    {
        io.scanShowJockeyDevices();
        var deviceCount = io.getShowJockeyDeviceCount();
        
        var dId = UInt32(deviceId + 1);
        
        //check if device id is in range
        if(deviceCount > UInt32(deviceId + 1)) {
            return false;
        }
        
        currentDevice = io.getShowJockeyDevice(deviceId);
        var openResult = io.openShowJockeyDevice(currentDevice);
        return true;
    }
    
    func closeDevice() -> Bool
    {
        var result = io.closeShowJockeyDevice(currentDevice);
        return result;
    }
    
    func sendAndGetDMXData(data:[UInt8]) -> Bool
    {
        var result = sendDMXData(data);
        getDMXData();
        return result;
    }
    
    func sendDMXData(data:[UInt8]) -> Bool
    {
        let pbuffer = UnsafeMutablePointer<UInt8>.alloc(bufferSize)
        pbuffer.initialize(data[0]);
        
        var result = io.sendShowJockeyDeviceBuf(currentDevice, andBuffer : pbuffer, andSize : UInt32(bufferSize));
        return result == 0;
    }
    
    func getDMXData() -> [UInt8]
    {
        var data = [UInt8](count:bufferSize, repeatedValue:0)
        
        let returnBuffer = UnsafeMutablePointer<UInt8>.alloc(bufferSize);
        let size = UnsafeMutablePointer<UInt32>.alloc(1);
        
        returnBuffer.initialize(data[0]);
        size.initialize(UInt32(bufferSize));
        
        io.getShowJockeyDeviceBuf(currentDevice, andBuffer: returnBuffer, andSize: size);
        
        return data;
    }
}