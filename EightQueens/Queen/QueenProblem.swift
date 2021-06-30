//
//  QueenProblem.swift
//  EightQueens
//
//  Created by zjj on 2021/6/30.
//

import Foundation

/**
 将n个皇后，放入n*n的棋盘中，使其不能相互攻击
 */
class QueenProblem {
    struct Solution {
        let count: Int
        let cols: [Int]
    }
    typealias SolutionHandler = (Solution)->()
    typealias FinishHandler = ()->()
    private var cols = [Int]()
    private var count = 0
    private var foundSolutionHandler: SolutionHandler? = nil
    private var canceled = false
    func placeQueens(_ count: Int, foundSolutionHandler: SolutionHandler?, finishHandler: FinishHandler?) {
        self.foundSolutionHandler = foundSolutionHandler
        DispatchQueue.global().async {
            self.placeQueens(count)
            DispatchQueue.main.async {
                finishHandler?()
            }
        }
    }
    
    func cancel() {
        self.canceled = true
    }
    
    private func placeQueens(_ count: Int) {
        if count < 1 {
            return;
        }
        self.canceled = false
        self.count = count
        self.cols.removeAll()
        for _ in 0 ..< count {
            self.cols.append(0)
        }
        placeRow(0)
    }
    
    private func placeRow(_ row: Int) {
        if self.canceled {
            return
        }
        if row >= count {
            // 得到一种摆法
            let solu = Solution(count: self.count, cols: self.cols)
            DispatchQueue.main.async {
                self.foundSolutionHandler?(solu)
            }
            return
        }
        for col in 0 ..< self.count {
            if self.isValid(row: row, col: col) {
                self.cols[row] = col
                placeRow(row + 1)
            }
        }
    }
    
    private func isValid(row: Int, col: Int) -> Bool {
        for r in 0 ..< row {
            let c = self.cols[r]
            if c == col {
                return false
            }
            if (row - r) == abs(col - c) {
                return false
            }
        }
        return true
    }
}
