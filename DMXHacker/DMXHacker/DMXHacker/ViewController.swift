//
//  ViewController.swift
//  DMXHacker
//
//  Created by Florian Bruggisser on 27/04/15.
//  Copyright (c) 2015 Florian Bruggisser. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, ArtNetReceiver {
    
    var artnetServer : ArtNetHack!
    var gridView = TSUniformGrid ()
    
    @IBOutlet weak var dataOutputText: NSTextField!
    @IBOutlet weak var customGridView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        artnetServer = ArtNetHack(artNetReceiver: self)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    func initializeGridView()
    {
        self.view.replaceSubview(customGridView, with: gridView)
        var buttons = [NSButton](count:512, repeatedValue:NSButton())
        for(var i = 0; i < 512; i++)
        {
            buttons[i].title = "\(i)"
        }
        
        gridView.addNewRowWithSubviews(buttons)
    }
    
    func DataReceived(dmxData:[UInt8])
    {
        //on data received
        //println("\(dmxData[0]), \(dmxData[1]), \(dmxData[2])")
        dataOutputText.stringValue = "Data: \(dmxData[0]), \(dmxData[1]), \(dmxData[2])"
    }

    @IBAction func StartDMXOutput_Clicked(sender: NSButton) {
        initializeGridView()
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

}

