//
//  ViewController.swift
//  DMXHacker
//
//  Created by Florian Bruggisser on 27/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, ArtNetReceiver, NSTableViewDataSource, NSTableViewDelegate  {
    
    var fixtureTable = FixtureTable()
    var artnetServer : ArtNetHack!
    
    @IBOutlet weak var dataOutputText: NSTextField!
    @IBOutlet weak var dmxTableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        artnetServer = ArtNetHack(artNetReceiver: self)
        
        //add fixtures
        var myLight = FixtureRGB(position:0)
        myLight.name = "RGB Parser"
        myLight.red = 255
        
        fixtureTable.fixtures.append(myLight)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func DataReceived(dmxData:[UInt8])
    {
        //on data received
        //println("\(dmxData[0]), \(dmxData[1]), \(dmxData[2])")
        
        dispatch_async(dispatch_get_main_queue()) {
            self.dataOutputText.stringValue = "Last Data: \(NSDate().timeIntervalSince1970)"
            self.fixtureTable.setDMXData(dmxData)
            self.dmxTableView.reloadDataForRowIndexes(NSIndexSet(index:0), columnIndexes: NSIndexSet(index:0))
        }
    }

    @IBAction func StartDMXOutput_Clicked(sender: NSButton) {
        fixtureTable.fixtures.append(FixtureRGB(position:0))
        dmxTableView.reloadData()
    }
    
    @IBAction func StartArtNet_Clicked(sender: NSButton) {
        if(artnetServer!.isRunning)
        {
            artnetServer.stop()
            sender.title = "Start ArtNet"
        }
        else
        {
            artnetServer.start()
            sender.title = "Stop ArtNet"
        }
    }

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return fixtureTable.fixtures.count
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        //selection changed
        println("selection changed")
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        if tableColumn!.identifier == "MainInfoColumn" {
            
            let fixture = fixtureTable.fixtures[row]
            
            cellView.imageView!.image = NSImage.swatchWithColor(fixture.color.getNSColor(), size: NSSize(width: 17, height: 17))
            cellView.textField!.stringValue = fixture.description
            return cellView
        }
        
        return cellView
    }
}

