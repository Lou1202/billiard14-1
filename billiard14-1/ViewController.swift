//
//  ViewController.swift
//  billiard14-1
//
//  Created by 楊曜安 on 2023/3/9.
//

import UIKit

class ViewController: UIViewController {

    var scoreA = 0
    var scoreB = 0
    var foulScoreA = 0
    var foulScoreB = 0
    var totalScoreA = 0
    var totalScoreB = 0
    
    @IBOutlet weak var teamAImageView: UIImageView!
    @IBOutlet weak var teamBImageView: UIImageView!
    @IBOutlet weak var scoreALabel: UILabel!
    @IBOutlet weak var scoreBLabel: UILabel!
    @IBOutlet weak var foulALabel: UILabel!
    @IBOutlet weak var foulBLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addScoreA(_ sender: Any) {
        
        if (scoreA + scoreB < 13){
            scoreA += 1
            teamAImageView.frame.origin.y = CGFloat(60 + 40 * scoreA)
        } else if (scoreA + scoreB < 14) {
            scoreA += 1
            teamAImageView.frame.origin.y = CGFloat(60 + 40 * scoreA)
            totalScoreA = totalScoreA + scoreA - foulScoreA
            totalScoreB = totalScoreB + scoreB - foulScoreB
            scoreALabel.text = totalScoreA.formatted()
            scoreBLabel.text = totalScoreB.formatted()
        }
        
        
    }
    
    @IBAction func addScoreB(_ sender: Any) {
        
        if (scoreA + scoreB < 13) {
            scoreB += 1
            teamBImageView.frame.origin.y = CGFloat(60 + 40 * scoreB)
        } else if (scoreA + scoreB < 14){
            scoreB += 1
            teamBImageView.frame.origin.y = CGFloat(60 + 40 * scoreB)
            totalScoreA = totalScoreA + scoreA - foulScoreA
            totalScoreB = totalScoreB + scoreB - foulScoreB
            scoreALabel.text = totalScoreA.formatted()
            scoreBLabel.text = totalScoreB.formatted()
            
        }
    }
    
    //A組犯規扣分
    @IBAction func reduceScoreA(_ sender: Any) {
        
        if (scoreA + scoreB != 14){
            foulScoreA += 1
            foulALabel.text = foulScoreA.formatted()
        }
    }
    
    //B組犯規扣分
    @IBAction func reduceScoreB(_ sender: Any) {
        
        if (scoreA + scoreB != 14){
            foulScoreB += 1
            foulBLabel.text = foulScoreB.formatted()
        }
    }
    
    @IBAction func changeNextGame(_ sender: Any) {
        
        if (scoreA + scoreB == 14){
            scoreA = 0
            scoreB = 0
            foulScoreA = 0
            foulScoreB = 0
            foulALabel.text = foulScoreA.formatted()
            foulBLabel.text = foulScoreB.formatted()
            teamAImageView.frame.origin.y = CGFloat(60)
            teamBImageView.frame.origin.y = CGFloat(60)
            
        }
    }
    
    
}

