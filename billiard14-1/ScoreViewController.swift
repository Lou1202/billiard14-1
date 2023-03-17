//
//  ScoreViewController.swift
//  billiard14-1
//
//  Created by 楊曜安 on 2023/3/9.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var playerAName: String!
    var playerBName: String!
    var gameScore: Int!
    var scoreA = 0
    var scoreB = 0
    var foulScoreA = 0
    var foulScoreB = 0
    var roundScoreA = 0
    var roundScoreB = 0
    var timer: Timer?
    var counter = 0
    var rounds = 0
    var getScoreArray = [String]()
    var totalScoreAArray = [0]
    var totalScoreBArray = [0]
    let playerAScore = "A"
    let playerBScore = "B"
    let playerAFoul = "A-"
    let playerBFoul = "B-"
    
    @IBOutlet weak var playerALabel: UILabel!
    @IBOutlet weak var playerBLabel: UILabel!
    @IBOutlet weak var gameScoreLabel: UILabel!
    @IBOutlet weak var playerABallView: UIView!
    @IBOutlet weak var playerBBallView: UIView!
    @IBOutlet weak var scoreALabel: UILabel!
    @IBOutlet weak var scoreBLabel: UILabel!
    @IBOutlet weak var foulALabel: UILabel!
    @IBOutlet weak var foulBLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialUI()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTime(){
        counter += 1
        timeLabel.text = formatedTime(counter)
    }
    
    
    func initialUI(){
        
        if playerAName != "" {
            playerALabel.text = playerAName
        } else {
            playerALabel.text = "A(先攻)"
        }
        
        if playerBName != ""{
            playerBLabel.text = playerBName
        } else {
            playerBLabel.text = "B(後攻)"
        }
        
        if gameScore != nil {
            gameScoreLabel.text = "獲勝總分:\( gameScore!.formatted())"
        } else {
            gameScoreLabel.text = "單局計分"
        }
        
    }
    
    
    //顯示時間格式
    func formatedTime(_ seconds: Int) -> String {
        var hourSting = String()
        var minString = String()
        var secString = String()
        
        if seconds / 3600 == 0 {
            hourSting = "00"
        } else if (seconds / 3600 > 0 && seconds / 3600 < 10 ){
            hourSting = "0\(seconds / 3600)"
        } else {
            hourSting = "\(seconds / 3600)"
        }
        
        if seconds / 60 == 0 {
            minString = "00"
        } else if (seconds / 60 > 0 && seconds / 60 < 10){
            minString = "0\(seconds / 60)"
        } else {
            minString = "\(seconds / 60)"
        }
        
        if seconds % 60 == 0 {
            secString = "00"
        } else if (seconds % 60 < 10){
            secString = "0\(seconds % 60)"
        } else {
            secString = "\(seconds % 60)"
        }
            
        return "比賽時間:\n\(hourSting):\(minString):\(secString)"
        
        
        
    }
    
    func resetGame(){
        
        initialUI()
        rounds = 0
        scoreA = 0
        scoreB = 0
        foulScoreA = 0
        foulScoreB = 0
        roundScoreA = 0
        roundScoreB = 0
        totalScoreAArray = [0]
        totalScoreBArray = [0]
        scoreALabel.text = roundScoreA.formatted()
        scoreBLabel.text = roundScoreB.formatted()
        foulALabel.text = foulScoreA.formatted()
        foulBLabel.text = foulScoreB.formatted()
        playerABallView.frame.origin.y = CGFloat(60)
        playerBBallView.frame.origin.y = CGFloat(60)
        getScoreArray.removeAll()
        
    }
    
    func showWinner(){
        var winnerName = String()
        
        if (roundScoreA + scoreA - foulScoreA) > (roundScoreB + scoreB - foulScoreB) {
            winnerName = playerALabel.text!
        } else {
            winnerName = playerBLabel.text!
        }
    
        
        let controller = UIAlertController(title: "恭喜\(winnerName)獲勝", message: "🏆🏆🏆🏆🏆🏆", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "重置比賽", style: .default){
            _ in
            self.resetGame()
        }
        controller.addAction(okAction)
        present(controller, animated: true)
        
        
        }
    
    
    
    
    @IBAction func addScoreA(_ sender: Any) {
        
        if scoreA + scoreB < 13 {
            scoreA += 1
            playerABallView.frame.origin.y = CGFloat(60 + 40 * scoreA)
            getScoreArray.append(playerAScore)
        } else if scoreA + scoreB < 14 {
            scoreA += 1
            playerABallView.frame.origin.y = CGFloat(60 + 40 * scoreA)
            roundScoreA = roundScoreA + scoreA - foulScoreA
            roundScoreB = roundScoreB + scoreB - foulScoreB
            scoreALabel.text = roundScoreA.formatted()
            scoreBLabel.text = roundScoreB.formatted()
            getScoreArray.append(playerAScore)
        }
        
        if gameScore != nil && gameScore > 0{
            if (roundScoreA + scoreA - foulScoreA) == gameScore {
                showWinner()
            }
        }
        
        
    }
    
    @IBAction func addScoreB(_ sender: Any) {
        
        if scoreA + scoreB < 13 {
            scoreB += 1
            playerBBallView.frame.origin.y = CGFloat(60 + 40 * scoreB)
            getScoreArray.append(playerBScore)
        } else if scoreA + scoreB < 14 {
            scoreB += 1
            playerBBallView.frame.origin.y = CGFloat(60 + 40 * scoreB)
            roundScoreA = roundScoreA + scoreA - foulScoreA
            roundScoreB = roundScoreB + scoreB - foulScoreB
            scoreALabel.text = roundScoreA.formatted()
            scoreBLabel.text = roundScoreB.formatted()
            getScoreArray.append(playerBScore)
        }
        
        if gameScore != nil && gameScore > 0{
            if (roundScoreB + scoreB) == gameScore {
                showWinner()
            }
        }
    }
    
    

    
    //A組犯規扣分
    @IBAction func reduceScoreA(_ sender: Any) {
        
        if scoreA + scoreB != 14 {
            foulScoreA += 1
            foulALabel.text = foulScoreA.formatted()
            getScoreArray.append(playerAFoul)
        }
    }
    
   
    //B組犯規扣分
    @IBAction func reduceScoreB(_ sender: Any) {
        
        if scoreA + scoreB != 14 {
            foulScoreB += 1
            foulBLabel.text = foulScoreB.formatted()
            getScoreArray.append(playerBFoul)
        }
    }
    
    
    @IBAction func reset(_ sender: Any) {
        
        let controller = UIAlertController(title: "重置比賽", message: "確定要重置比賽", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default){ _ in
            self.resetGame()
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(cancelAction)
        present(controller, animated: true)
        
    }
    
    //繼續下一局
    @IBAction func changeNextGame(_ sender: Any) {
        
        if scoreA + scoreB == 14 {
            scoreA = 0
            scoreB = 0
            foulScoreA = 0
            foulScoreB = 0
            rounds += 1
            foulALabel.text = foulScoreA.formatted()
            foulBLabel.text = foulScoreB.formatted()
            playerABallView.frame.origin.y = CGFloat(60)
            playerBBallView.frame.origin.y = CGFloat(60)
            totalScoreAArray.append(roundScoreA)
            totalScoreBArray.append(roundScoreB)
            getScoreArray.removeAll()
        }
    }
    
    
    //恢復上一步
    @IBAction func rewind(_ sender: Any) {
        let lastScore = getScoreArray.popLast()
        
        switch lastScore {
            
        case playerAScore:
            if scoreA + scoreB == 14 {
                scoreA -= 1
                playerABallView.frame.origin.y = CGFloat(60 + 40 * scoreA)
                roundScoreA = totalScoreAArray[rounds]
                roundScoreB = totalScoreBArray[rounds]
                scoreALabel.text = roundScoreA.formatted()
                scoreBLabel.text = roundScoreB.formatted()
                
            } else {
                scoreA -= 1
                playerABallView.frame.origin.y = CGFloat(60 + 40 * scoreA)
            }
            
        case playerBScore:
            if scoreA + scoreB == 14 {
                scoreB -= 1
                playerBBallView.frame.origin.y = CGFloat(60 + 40 * scoreB)
                roundScoreA = totalScoreAArray[rounds]
                roundScoreB = totalScoreBArray[rounds]
                scoreALabel.text = roundScoreA.formatted()
                scoreBLabel.text = roundScoreB.formatted()
                
            } else {
                scoreB -= 1
                playerBBallView.frame.origin.y = CGFloat(60 + 40 * scoreB)
            }
            
        case playerAFoul:
            foulScoreA -= 1
            foulALabel.text = foulScoreA.formatted()
        
        case playerBFoul:
            foulScoreB -= 1
            foulBLabel.text = foulScoreB.formatted()
        
        default:
            break
        }
        
    }
    
    
    
  
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
