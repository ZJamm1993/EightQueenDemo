//
//  QueenViewController.swift
//  EightQueens
//
//  Created by zjj on 2021/6/30.
//

import UIKit

class QueenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellIdentifier = "afodsihais"
    var queenCount: Int = 1
    var cellSize: CGSize = QueenView.boardSizeForCount(1)
    var queenProblem = QueenProblem()
    var solutions = [QueenProblem.Solution]()
    @IBOutlet var collectionView: UICollectionView!
    
    deinit {
        self.queenProblem.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = "0"
        
        self.collectionView.register(QueenSolutionCollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        let refreshTitle = { [weak self] (finished: Bool) in
            self?.navigationItem.title = "\(self?.solutions.count ?? 0)\(finished ? "" : "...")"
        }
        let refreshData = { [weak self] in
            self?.collectionView.reloadData()
        }
        var lastTime = Date.timeIntervalSinceReferenceDate
        var didLoadFirst = false
        self.queenProblem.placeQueens(self.queenCount) { [weak self] (solu) in
            self?.solutions.append(solu)
            let now = Date.timeIntervalSinceReferenceDate
            if now - lastTime > 0.1 {
                lastTime = now
                refreshTitle(false)
                if didLoadFirst == false {
                    didLoadFirst = true
                    refreshData()
                }
            }
        } finishHandler: {
            refreshTitle(true)
            refreshData()
        }
        // Do any additional setup after loading the view.
    }
    
    // MARK: collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.solutions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! QueenSolutionCollectionViewCell
        cell.queenView.queenSolution = self.solutions[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
}
