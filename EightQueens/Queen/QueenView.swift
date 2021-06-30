//
//  QueenView.swift
//  EightQueens
//
//  Created by zjj on 2021/6/30.
//

import UIKit

class QueenView: UIView {
    static func boardSizeForCount(_ count: Int) -> CGSize {
//        let min: CGFloat = 32
//        let max: CGFloat = 192
//        let deltaW = max - min
//        let deltaC = CGFloat(count - 1) / 24.0
        let w = UIScreen.main.bounds.width / 5 //deltaC * deltaW + min
        return CGSize(width: w, height: w)
    }
    static func blockSizeForCount(_ count: Int) -> CGSize {
        let size = self.boardSizeForCount(count)
        let w = size.width / CGFloat(count)
        let h = size.height / CGFloat(count)
        return CGSize(width: w, height: h)
    }
    
    var queenViews = [UILabel]()
    var boardViews = [UIView]()
    var queenSolution: QueenProblem.Solution? = nil {
        didSet {
            if let solu = self.queenSolution {
                if oldValue?.count != solu.count {
                    self.removeAll()
                    self.createBoard()
                    self.createQueens()
                }
                self.showQueens()
            }
        }
    }
    
    func removeAll() {
        for i in self.queenViews {
            i.removeFromSuperview()
        }
        for i in self.boardViews {
            i.removeFromSuperview()
        }
        self.queenViews.removeAll()
        self.boardViews.removeAll()
    }
    
    func createBoard() {
        if let q = self.queenSolution {
            let size = QueenView.blockSizeForCount(q.count)
            for row in 0 ..< q.count {
                for col in 0 ..< q.count {
                    if (row & 1 == col & 1) {
                        let x = CGFloat(col) * size.width
                        let y = CGFloat(row) * size.height
                        let frame = CGRect(origin: CGPoint(x: x, y: y), size: size)
                        let block = UIView(frame: frame)
                        block.backgroundColor = .black
                        self.boardViews.append(block)
                        self.addSubview(block)
                    }
                }
            }
        }
    }
    
    func createQueens() {
        if let q = self.queenSolution {
            for _ in 0 ..< q.count {
                let queen = UILabel()
                queen.text = "👸🏻"
                queen.textAlignment = .center
                queen.adjustsFontSizeToFitWidth = true
                queen.minimumScaleFactor = 0.1
                queen.font = .systemFont(ofSize: 100)
                self.queenViews.append(queen)
                self.addSubview(queen)
            }
        }
    }
    
    func showQueens() {
        if let q = self.queenSolution {
            let size = QueenView.blockSizeForCount(q.count)
            for row in 0 ..< q.count {
                let col = q.columnIndexForRows[row]
                let x = CGFloat(col) * size.width
                let y = CGFloat(row) * size.height
                let frame = CGRect(origin: CGPoint(x: x, y: y), size: size)
                let queen = self.queenViews[row]
                queen.frame = frame
            }
        }
    }
}
