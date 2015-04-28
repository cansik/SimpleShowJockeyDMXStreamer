//
//  ArtNetHack.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 26/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

class ArtNetHack {
    private let artNetReceiver : ArtNetReceiver
    private var run:Bool=false
    private var server = UDPServer(addr:"0.0.0.0",port:0x1936)
    
    var isRunning : Bool {
        get {
            return run
        }
    }

    
    init(artNetReceiver : ArtNetReceiver)
    {
        self.artNetReceiver = artNetReceiver
    }
    
    func start(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            self.server = UDPServer(addr:"0.0.0.0",port:0x1936) //6454
            self.run = true
            println("server started!")
            while self.run {
                var (data,remoteip,remoteport)=self.server.recv(1024)
                if let d=data {
                    
                    //println("\(NSDate().timeIntervalSince1970) -> dmx: \(d.count)")
                    if(d.count == 530)
                    {
                        var dmxData = self.getDMXDataPacket(d)
                        self.artNetReceiver.DataReceived(dmxData)
                    }
                }
            }
            
            self.server.close()
            println("server closed!")
        })
    }
    
    func stop()
    {
        run = false
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
}