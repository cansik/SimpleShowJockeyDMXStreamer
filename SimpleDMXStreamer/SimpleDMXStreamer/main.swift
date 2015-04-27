//
//  main.swift
//  SimpleDMXStreamer
//
//  Created by Florian Bruggisser on 25/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

println("ShowJockey Streamer");

var artNet = ArtNetHack()
artNet.start();

/*
var streamer = DMXStreamer();
streamer.fixtureTest();
*/

getchar()

println("stopped!")