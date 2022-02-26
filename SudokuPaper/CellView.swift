//
//  CellView.swift
//  SudokuPaper
//
//  Created by Kela on 2022/2/26.
//

import Cocoa
import Combine

class CellView: NSView {
    
    enum CellState {
        case normal
        case scope
        case selected
    }
    
    enum Value {
        case empty
        case input(Int)
        case notes(Set<Int>)
    }
    
    var state = CellState.normal
    
    var value = CurrentValueSubject<Value, Never>(.empty)
    
    private var cancels = Set<AnyCancellable>()
    
    private let inputLabel = NSTextField()
    private let noteView = NoteView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        inputLabel.isEditable = false
        inputLabel.isBezeled = false
        inputLabel.backgroundColor = NSColor.clear
        inputLabel.font = NSFont.systemFont(ofSize: 40, weight: .light)
        addSubview(inputLabel)
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        noteView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(noteView)
        
        NSLayoutConstraint.activate([
            inputLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            inputLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noteView.leftAnchor.constraint(equalTo: leftAnchor),
            noteView.topAnchor.constraint(equalTo: topAnchor),
            noteView.rightAnchor.constraint(equalTo: rightAnchor),
            noteView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        value.sink { [unowned self] value in
            switch value {
            case .empty:
                self.inputLabel.stringValue = ""
                self.noteView.isHidden = true
            case .notes(let notes):
                self.inputLabel.stringValue = ""
                self.noteView.isHidden = false
                self.noteView.notes = notes
            case .input(let input):
                self.inputLabel.stringValue = String(input)
                self.noteView.isHidden = true
            }
        }.store(in: &cancels)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
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

class NoteView: NSView {
    
    let gridView: NSGridView!
    
    var notes: Set<Int> = [] {
        didSet {
            var i = 0
            for row in 0...2 {
                for column in 0...2 {
                    i += 1
                    gridView.cell(atColumnIndex: column, rowIndex: row).contentView?.isHidden = !notes.contains(i)
                }
            }
        }
    }
    
    override init(frame frameRect: NSRect) {
        
        var views: [[NSView]] = []

        var i = 1
        for _ in 0...2 {
            var rows = [NSView]()
            for _ in 0...2 {
                let label = NSTextField()
                label.isEditable = false
                label.isBezeled = false
                label.backgroundColor = NSColor.clear
                label.textColor = NSColor.secondaryLabelColor
                label.translatesAutoresizingMaskIntoConstraints = false
                label.widthAnchor.constraint(equalToConstant: 50.0 / 3).isActive = true
                label.heightAnchor.constraint(equalToConstant: 50.0 / 3).isActive = true
                label.stringValue = "\(i)"
                label.alignment = .center
                rows.append(label)
                i += 1
            }
            views.append(rows)
        }
        gridView = NSGridView(views: views)
        gridView.rowSpacing = 0
        gridView.columnSpacing = 0
        gridView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frameRect)
        
        addSubview(gridView)
        NSLayoutConstraint.activate([
            gridView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
