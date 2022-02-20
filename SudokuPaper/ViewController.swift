//
//  ViewController.swift
//  SudokuPaper
//
//  Created by Kela on 2022/2/19.
//

import Cocoa

class ViewController: NSViewController {
    
    let sudokuView = SudokuView()

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
        print("mouse")
    }

    override func keyDown(with event: NSEvent) {
        print("key")
    }
}
