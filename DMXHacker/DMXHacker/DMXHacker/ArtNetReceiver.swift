//
//  ArtNetReceiver.swift
//  DMXHacker
//
//  Created by Florian Bruggisser on 27/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Foundation

protocol ArtNetReceiver
{
    func DataReceived(dmxData:[UInt8])
}