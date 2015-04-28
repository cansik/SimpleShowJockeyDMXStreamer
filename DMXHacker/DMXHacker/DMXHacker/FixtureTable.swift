//
//  FixtureTable.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 26/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

class FixtureTable
{
    var fixtures = [Fixture]();
    
    init()
    {
        
    }
    
    func getDMXData() -> [UInt8]
    {
        var data = [UInt8](count:512, repeatedValue:0);
        
        for fix in fixtures
        {
            for(var i = 0; i < fix.data.count; i++)
            {
                data[i+fix.position] = fix[i];
            }
        }
        
        return data;
    }
    
    func setDMXData(data : [UInt8])
    {
        for fix in fixtures
        {
            for(var i = 0; i < fix.data.count; i++)
            {
                fix[i] = data[i+fix.position]
            }
        }
    }
}