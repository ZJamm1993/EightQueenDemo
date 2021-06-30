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
        let columnIndexForRows: [Int]
    }
    typealias SolutionHandler = (Solution)->()
    typealias FinishHandler = ()->()
    private var columnIndexForRows = [Int]()
    private var existForColumns = [Bool]()
    private var existForLeftTop = [Bool]()
    private var existForRightTop = [Bool]()
    private var count = 0
    private var foundSolutionHandler: SolutionHandler? = nil
    private var canceled = false
    
    func placeQueens(_ count: Int, foundSolutionHandler: SolutionHandler?, finishHandler: FinishHandler?) {
        self.foundSolutionHandler = foundSolutionHandler
        DispatchQueue.global().async {
            let start = Date.timeIntervalSinceReferenceDate
            self.placeQueens(count)
            let end = Date.timeIntervalSinceReferenceDate
            let timeInterval = end - start
            print("wasted Time: \(timeInterval)")
            if let fi = finishHandler {
                DispatchQueue.main.async {
                    fi()
                }
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
        self.columnIndexForRows = [Int]()
        self.existForColumns = [Bool]()
        self.existForLeftTop = [Bool]()
        self.existForRightTop = [Bool]()
        for _ in 0 ..< count {
            self.columnIndexForRows.append(0)
            self.existForColumns.append(false)
        }
        for _ in 0 ..< (count * 2 - 1) {
            self.existForLeftTop.append(false)
            self.existForRightTop.append(false)
        }
        placeRow(0)
    }
    
    private func placeRow(_ row: Int) {
        if self.canceled {
            return
        }
        if row >= count {
            // 得到一种摆法
            let solu = Solution(count: self.count, columnIndexForRows: self.columnIndexForRows)
            if let fo = self.foundSolutionHandler {
                DispatchQueue.main.async {
                    fo(solu)
                }
            }
            return
        }
        for col in 0 ..< self.count {
            /*
            // 直接根据遍历每一行记录的列号==col判断
            for r in 0 ..< row {
                let c = self.columnIndexForRows[r]
                if c == col {
                    continue
                }
                if (row - r) == abs(col - c) {
                    continue
                }
            }
             */ //wasted Time: 32.29834604263306 for 12 queens
            
            // 通过列、对角线记录的bool直接判断
            if self.existForColumns[col] {
                continue
            }
            let leftTopIndex = row - col + self.count - 1
            if self.existForLeftTop[leftTopIndex] {
                continue
            }
            let rightTopIndex = row + col
            if self.existForRightTop[rightTopIndex] {
                continue
            }
            // wasted Time: 6.022248983383179 for 12 queens
            
            self.columnIndexForRows[row] = col
            self.existForColumns[col] = true
            self.existForLeftTop[leftTopIndex] = true
            self.existForRightTop[rightTopIndex] = true
            placeRow(row + 1)
            // 回溯时必要的还原操作
            self.existForColumns[col] = false
            self.existForLeftTop[leftTopIndex] = false
            self.existForRightTop[rightTopIndex] = false
        }
    }
}
