//
//  ArtNetHack.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 26/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

class ArtNetHack {
    
    var controller : DMXController
    var dmxConnected : Bool = false
    
    
    init()
    {
        controller = DMXController()
    }
    
    func start(){
        dmxConnected = controller.openDevice(0)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            var server:UDPServer=UDPServer(addr:"0.0.0.0",port:0x1936) //6454
            var run:Bool=true
            println("server started!")
            while run{
                var (data,remoteip,remoteport)=server.recv(1024)
                if let d=data{
                    
                    //print("dmx: \(d.count)")
                    if(d.count == 530)
                    {
                        var dmxData = self.getDMXDataPacket(d)
                        println("\(dmxData[0]), \(dmxData[1]), \(dmxData[2])")
                        
                        self.controller.sendDMXData(dmxData)
                    }
                    else
                    {
                        println()
                    }
                }
            }
            
            server.close()
            self.controller.closeDevice()
        })
    }
    
    private func getDMXDataPacket(data:[UInt8]) -> [UInt8]
    {
        let startSize = 18
        var dmxData = [UInt8](count: 512, repeatedValue: 0)
        
        for(var i = 0; i < 512; i++)
        {
            dmxData[i] = data[i + startSize]
        }
        
        return dmxData
    }
    
    private func DoSomethingSend()
    {
        
    }
}