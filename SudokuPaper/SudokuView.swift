//
//  SudokuView.swift
//  SudokuPaper
//
//  Created by Kela on 2022/2/19.
//

import Cocoa

let cellSize: CGFloat = 50

class SudokuView: NSView {
    
    var gridView: NSGridView!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        var views: [[NSView]] = []

        for _ in 0...8 {
            var rows = [NSView]()
            for _ in 0...8 {
                rows.append(CellView())
            }
            views.append(rows)
        }
        gridView = NSGridView(views: views)
        gridView.rowSpacing = 0
        gridView.columnSpacing = 0
        addSubview(gridView)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        
        let lineView = GridLineView()
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gridView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lineView.widthAnchor.constraint(equalTo: gridView.widthAnchor),
            lineView.heightAnchor.constraint(equalTo: gridView.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override var acceptsFirstResponder: Bool { true }

    override var intrinsicContentSize: NSSize { NSSize(width: cellSize * 9, height: cellSize * 9) }
    
    func select(row: Int, column: Int) {
        for i in 0...8 {
            for j in 0...8 {
                let cell = gridView.cell(atColumnIndex: j, rowIndex: i)
                if let cellView = cell.contentView as? CellView {
                    if i == row && j == column {
                        cellView.state = .selected
                    } else if i == row || j == column {
                        cellView.state = .scope
                    } else {
                        cellView.state = .normal
                    }
                    cellView.needsDisplay = true
                }
            }
        }
    }
}

class CellView: NSView {
    
    enum CellState {
        case normal
        case scope
        case selected
    }
    
    var state = CellState.normal
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        switch state {
        case .normal:
            NSColor(named: "CellBackground")!.setFill()
        case .scope:
            NSColor(named: "CellScope")!.setFill()
        case .selected:
            NSColor(named: "CellSelected")!.setFill()
        }
        
        dirtyRect.fill()
    }
    
    override var intrinsicContentSize: NSSize {
        NSSize(width: cellSize, height: cellSize)
    }
}
