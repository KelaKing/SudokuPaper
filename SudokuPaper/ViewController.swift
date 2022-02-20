//
//  ViewController.swift
//  SudokuPaper
//
//  Created by Kela on 2022/2/19.
//

import Cocoa

enum SelectState {
    case none
    case selected(row: Int, column: Int)
}

class ViewController: NSViewController {
    
    let sudokuView = SudokuView()
    var selectState = SelectState.none

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sudokuView)
        sudokuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sudokuView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sudokuView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func mouseDown(with event: NSEvent) {
        let point = view.convert(event.locationInWindow, to: sudokuView)
        
        let column = Int(point.x.rounded()) / Int(cellSize)
        let row = 8 - Int(point.y.rounded()) / Int(cellSize)
        
        switch selectState {
        case .none:
            selectState = .selected(row: row, column: column)
        case .selected(let oldRow, let oldColumn):
            if row == oldRow && column == oldColumn {
                selectState = .none
            } else {
                selectState = .selected(row: row, column: column)
            }
        }
        
        print("New state: \(selectState)")
    }

    override func keyDown(with event: NSEvent) {
        print("key")
    }
}
