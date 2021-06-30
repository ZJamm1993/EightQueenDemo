//
//  QueenSolutionCollectionViewCell.swift
//  EightQueens
//
//  Created by zjj on 2021/6/30.
//

import UIKit

class QueenSolutionCollectionViewCell: UICollectionViewCell {
    var queenView: QueenView
    override init(frame: CGRect) {
        self.queenView = QueenView()
        super.init(frame: frame)
        self.backgroundColor = .white
        self.contentView.addSubview(queenView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
