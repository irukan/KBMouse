//
//  KBMouse.swift
//  KBMouse
//
//  Created by kayama on 2015/09/12.
//  Copyright (c) 2015年 kayama. All rights reserved.
//

import Foundation
import Cocoa

let KBM = KBMouse()

let KEY_LEFT = 123
let KEY_RIGHT = 124
let KEY_UP = 126
let KEY_DOWN = 125
let KEY_D = 2

class KBMouse: NSObject
{
    private override init(){}
    
    func keyEvent(event: NSEvent!)
    {
        println(event.keyCode)
    }
    
    
}