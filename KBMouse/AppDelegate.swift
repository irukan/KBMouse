//
//  AppDelegate.swift
//  KBMouse
//
//  Created by kayama on 2015/09/10.
//  Copyright (c) 2015年 kayama. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

   // @IBOutlet weak var window: NSWindow!

    // システム環境設定に設定変更を依頼する
    func acquirePrivileges() -> Bool {
        let accessEnabled = AXIsProcessTrustedWithOptions(
            [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true])
        
        if accessEnabled != 1 {
            println("You need to enable the keylogger in the System Prefrences")
        }
        return accessEnabled == 1
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    
       let menu = Menu()
        
        acquirePrivileges()
        // keyboard listeners
        
        // KeyDown
        NSEvent.addGlobalMonitorForEventsMatchingMask(
            NSEventMask.KeyDownMask, handler: {(event: NSEvent!) in
                KBM.keyDownEvent(event)
            })
        
        // KeyUp
        NSEvent.addGlobalMonitorForEventsMatchingMask(
            NSEventMask.KeyUpMask, handler: {(event: NSEvent!) in
                KBM.keyUpEvent(event)
        })
        
    }
    
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func quit(sender: NSButton) {
        NSApplication.sharedApplication().terminate(self)
    }
}

