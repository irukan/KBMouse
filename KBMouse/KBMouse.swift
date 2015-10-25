//
//  KBMouse.swift
//  KBMouse
//
//  Created by kayama on 2015/09/12.
//  Copyright (c) 2015年 kayama. All rights reserved.
//

import Foundation
import Cocoa
import CoreGraphics

let KBM = KBMouse()

let KEY_LEFT:UInt16 = 123
let KEY_RIGHT:UInt16 = 124
let KEY_UP:UInt16 = 126
let KEY_DOWN:UInt16 = 125
let KEY_D:UInt16 = 2
let KEY_F:UInt16 = 3



class KBMouse: NSObject
{
    private override init(){}

    let hotKey = NSEventModifierFlags.ControlKeyMask
    let KEY_Trigger = KEY_D
    
    let KEY_LeftClick = KEY_F

    var isEnable = false
    
    func keyDownEvent(event: NSEvent!)
    {
        print(event.keyCode)
        let keyCode = event.keyCode
        
        _ = event.modifierFlags
        let cursorPos = event.locationInWindow
        
        switch (keyCode)
        {
        case KEY_LEFT, KEY_RIGHT, KEY_UP, KEY_DOWN:
            
            if (isEnable)
            {
                moveCursor(cursorPos, dir: convDirection(keyCode), speed: 10.0)
            }
            break
        case KEY_LeftClick:
            
            if (isEnable)
            {
                leftClick(cursorPos)
            }
            break
        case KEY_Trigger:
            // 後で長押しできたら
            isEnable = true
            break
        default:
            break
        }
        
    }
    
    func keyUpEvent(event: NSEvent!)
    {
        let keyCode = event.keyCode
        if (keyCode == KEY_Trigger)
        {
            isEnable = false
        }
    }
    
    enum Direction
    {
        case UP
        case DOWN
        case RIGHT
        case LEFT
        case ERR
    }
    
    func convDirection(keyCode: UInt16)->Direction
    {
        switch(keyCode)
        {
        case KEY_UP: return Direction.UP
        case KEY_DOWN: return Direction.DOWN
        case KEY_RIGHT: return Direction.RIGHT
        case KEY_LEFT: return Direction.LEFT
        default: return Direction.ERR
        }
    }
    
    func moveCursor(currentPos: CGPoint, dir:Direction, speed: CGFloat)
    {
        let screen = NSScreen.screens()!.first!
        let height = screen.frame.size.height
        
//        switch (dir)
//        {
//        case Direction.UP:
//            CGWarpMouseCursorPosition(CGPoint(x: currentPos.x , y: height - currentPos.y - speed))
//        case Direction.DOWN:
//            CGWarpMouseCursorPosition(CGPoint(x: currentPos.x , y: height - currentPos.y + speed))
//        case Direction.RIGHT:
//            CGWarpMouseCursorPosition(CGPoint(x: currentPos.x + speed, y: height - currentPos.y))
//        case Direction.LEFT:
//            CGWarpMouseCursorPosition(CGPoint(x: currentPos.x - speed , y: height - currentPos.y))
//            
//        default:
//            break
//        }
        
        var newPos:CGPoint = CGPoint()
        
        switch(dir)
        {
        case Direction.UP:
            newPos = CGPoint(x: currentPos.x , y: height - currentPos.y - speed)
        case Direction.DOWN:
            newPos = CGPoint(x: currentPos.x , y: height - currentPos.y + speed)
        case Direction.RIGHT:
            newPos = CGPoint(x: currentPos.x + speed , y: height - currentPos.y )
        case Direction.LEFT:
            newPos = CGPoint(x: currentPos.x - speed,  y: height - currentPos.y )
            
        default:
            break
        }
        
        //CGPoint(x: currentPos.x , y: height - currentPos.y - speed)
        let mouseDrag = CGEventCreateMouseEvent(nil, CGEventType.LeftMouseDragged, newPos, CGMouseButton.Left)
        
        CGEventPost(CGEventTapLocation.CGHIDEventTap, mouseDrag)
    }
    
    func leftClick(pos: CGPoint)
    {
        let screen = NSScreen.screens()!.first!
        let height = screen.frame.size.height
        
        let clickPos = CGPoint(x: pos.x , y: height - pos.y)
        
        let mouseDown = CGEventCreateMouseEvent(nil, CGEventType.LeftMouseDown, clickPos, CGMouseButton.Left)
        CGEventPost(CGEventTapLocation.CGHIDEventTap, mouseDown)
    }
    
}