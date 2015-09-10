//
//  Menu.swift
//  KBMouse
//
//  Created by kayama on 2015/09/11.
//  Copyright (c) 2015年 kayama. All rights reserved.
//

import Cocoa

let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

class Menu: NSStatusItem {

    override init() {
        let menu = NSMenu()
        statusItem.title = "KBMouse"
        statusItem.highlightMode = true
        statusItem.menu = menu
        
        let menuItem = NSMenuItem()
        menuItem.title = "Quit"
        menuItem.action = Selector("quit:")
        menu.addItem(menuItem)
    }
}

