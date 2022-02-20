//
//  GridLineView.swift
//  SudokuPaper
//
//  Created by Kela on 2022/2/20.
//

import Cocoa

class GridLineView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor(named: "DividerWeight")!.set()
        let line = NSBezierPath()
        line.move(to: NSPoint(x: 0, y: 0))
        line.line(to: NSPoint(x: 0, y: dirtyRect.height))
        line.line(to: NSPoint(x: dirtyRect.width, y: dirtyRect.height))
        line.line(to: NSPoint(x: dirtyRect.width, y: 0))
        line.line(to: NSPoint(x: 0, y: 0))
        line.lineWidth = 2
        line.stroke()
        
        for i in 1...8 {
            line.removeAllPoints()
            if i % 3 == 0 {
                line.lineWidth = 1
                NSColor(named: "DividerWeight")!.set()
            } else {
                line.lineWidth = 0.5
                NSColor(named: "DividerLight")!.set()
            }

            line.move(to: NSPoint(x: dirtyRect.width / 9 * CGFloat(i), y: 0))
            line.line(to: NSPoint(x: dirtyRect.width / 9 * CGFloat(i), y: dirtyRect.height))
            line.stroke()
            
            line.move(to: NSPoint(x: 0, y: dirtyRect.width / 9 * CGFloat(i)))
            line.line(to: NSPoint(x: dirtyRect.width, y: dirtyRect.width / 9 * CGFloat(i)))
            line.stroke()
        }
    }
    
}
