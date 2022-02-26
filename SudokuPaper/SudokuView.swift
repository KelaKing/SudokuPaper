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
    
    private var selectedCell: CellView?
    private var selected: (row: Int, column: Int) = (0, 0)

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
    
    // MARK: - Select
    
    func select(row: Int, column: Int) {
        selected = (row, column)
        for i in 0...8 {
            for j in 0...8 {
                let cell = gridView.cell(atColumnIndex: j, rowIndex: i)
                if let cellView = cell.contentView as? CellView {
                    if i == row && j == column {
                        cellView.state = .selected
                        selectedCell = cellView
                    } else if i == row || j == column {
                        cellView.state = .scope
                    } else if i / 3 == row / 3 && j / 3 == column / 3 {
                        cellView.state = .scope
                    } else {
                        cellView.state = .normal
                    }
                    cellView.needsDisplay = true
                }
            }
        }
    }
    
    func selectPrevious() {
        var newSelected = (selected.row, selected.column - 1)
        if newSelected.1 == -1 {
            newSelected.0 = selected.row == 0 ? 8 : selected.row - 1
            newSelected.1 = 8
        }
        select(row: newSelected.0, column: newSelected.1)
    }
    
    func selectNext() {
        var newSelected = (selected.row, selected.column + 1)
        if newSelected.1 == 9 {
            newSelected.0 = selected.row == 8 ? 0 : selected.row + 1
            newSelected.1 = 0
        }
        select(row: newSelected.0, column: newSelected.1)
    }
    
    func selectUp() {
        var newSelected = (selected.row - 1, selected.column)
        if newSelected.0 == -1 {
            newSelected.0 = 8
        }
        select(row: newSelected.0, column: newSelected.1)
    }
    
    func selectDown() {
        var newSelected = (selected.row + 1, selected.column)
        if newSelected.0 == 9 {
            newSelected.0 = 0
        }
        select(row: newSelected.0, column: newSelected.1)
    }
    
    func input(_ value: Int) {
        selectedCell?.value.send(.input(value))
    }
    
    func delete() {
        selectedCell?.value.send(.empty)
    }
    
    func inputNote(_ value: Int) {
        if case var .notes(notes) = selectedCell?.value.value {
            if notes.contains(value) {
                notes.remove(value)
            } else {
                notes.insert(value)                
            }
            selectedCell?.value.send(.notes(notes))
        } else {
            selectedCell?.value.send(.notes([value]))
        }
    }
}
