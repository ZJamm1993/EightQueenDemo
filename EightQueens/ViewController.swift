//
//  ViewController.swift
//  EightQueens
//
//  Created by zjj on 2021/6/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var queenLabel: UILabel!
    var queenCount: Int = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func slider(_ sender: UISlider) {
        let count = Int(sender.value)
        self.queenCount = count
        self.queenLabel.text = "\(count)皇后"
    }
    
    @IBAction func test(_ sender: Any) {
        let qvc = QueenViewController()
        qvc.queenCount = self.queenCount
        self.navigationController?.pushViewController(qvc, animated: true)
    }
}

