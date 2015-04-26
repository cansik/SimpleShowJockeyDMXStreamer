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
