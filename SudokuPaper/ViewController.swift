//
//  ViewController.swift
//  SudokuPaper
//
//  Created by Kela on 2022/2/19.
//

import Cocoa

class ViewController: NSViewController {
    
    let sudokuView = SudokuView()
    var selectedPosition: (row: Int, column: Int) = (0, 0) {
        didSet {
            sudokuView.select(row: selectedPosition.row, column: selectedPosition.column)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sudokuView)
        sudokuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sudokuView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sudokuView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        sudokuView.select(row: 0, column: 0)
    }

    override func mouseDown(with event: NSEvent) {
        let point = view.convert(event.locationInWindow, to: sudokuView)
        
        let column = Int(point.x.rounded()) / Int(cellSize)
        let row = 8 - Int(point.y.rounded()) / Int(cellSize)
        
        selectedPosition = (row, column)
    }

    override func keyDown(with event: NSEvent) {
        print("key: \(event.charactersIgnoringModifiers)")
    }
}
