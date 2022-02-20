//
//  SudokuView.swift
//  SudokuPaper
//
//  Created by Kela on 2022/2/19.
//

import Cocoa

let cellSize: CGFloat = 50

class SudokuView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let gridView = NSGridView(views: [
            [BlockView(index: 0), BlockView(index: 1), BlockView(index: 2)],
            [BlockView(index: 3), BlockView(index: 4), BlockView(index: 5)],
            [BlockView(index: 6), BlockView(index: 7), BlockView(index: 8)],
        ])
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
}

class BlockView: NSView {
    
    private let index: Int
    
    init(index: Int) {
        self.index = index
        
        super.init(frame: .zero)
        
        let gridView = NSGridView(views: [
            [CellView(index: 0), CellView(index: 1), CellView(index: 2)],
            [CellView(index: 3), CellView(index: 4), CellView(index: 5)],
            [CellView(index: 6), CellView(index: 7), CellView(index: 8)],
        ])
        gridView.rowSpacing = 0
        gridView.columnSpacing = 0

        gridView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gridView)
        NSLayoutConstraint.activate([
            gridView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override var intrinsicContentSize: NSSize { NSSize(width: cellSize * 3, height: cellSize * 3) }
}

class CellView: NSView {
    
    private let index: Int
    
    init(index: Int) {
        self.index = index
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor(named: "CellBackground")!.setFill()
        dirtyRect.fill()
    }
    
    override var intrinsicContentSize: NSSize {
        NSSize(width: cellSize, height: cellSize)
    }
}
