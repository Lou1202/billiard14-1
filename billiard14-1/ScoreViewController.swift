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
    @IBOutlet weak var score0Label: UILabel!
    @IBOutlet weak var score1Label: UILabel!
    @IBOutlet weak var score2Label: UILabel!
    @IBOutlet weak var score3Label: UILabel!
    @IBOutlet weak var score4Label: UILabel!
    @IBOutlet weak var score5Label: UILabel!
    @IBOutlet weak var score6Label: UILabel!
    @IBOutlet weak var score7Label: UILabel!
    @IBOutlet weak var score8Label: UILabel!
    @IBOutlet weak var score9Label: UILabel!
    @IBOutlet weak var score10Label: UILabel!
    @IBOutlet weak var score11Label: UILabel!
    @IBOutlet weak var score12Label: UILabel!
    @IBOutlet weak var score13Label: UILabel!
    @IBOutlet weak var score14Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: true)
        initialUI()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        //進入畫面frame還沒計算好,先隱藏起來
        playerABallView.isHidden = true
        playerBBallView.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let offsetX: CGFloat = 50
        playerABallView.frame.origin.y = score0Label.frame.origin.y
        playerABallView.frame.origin.x = score0Label.frame.origin.x - offsetX
        playerBBallView.frame.origin.y = score0Label.frame.origin.y
        playerBBallView.frame.origin.x = score0Label.frame.origin.x + offsetX
        //frame計算好顯示計分view
        playerABallView.isHidden = false
        playerBBallView.isHidden = false
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
        
        let offsetX: CGFloat = 50
        playerABallView.frame.origin.y = score0Label.frame.origin.y
        playerABallView.frame.origin.x = score0Label.frame.origin.x - offsetX
        playerBBallView.frame.origin.y = score0Label.frame.origin.y
        playerBBallView.frame.origin.x = score0Label.frame.origin.x + offsetX
        
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
        let resetAction = UIAlertAction(title: "維持設定 重新比賽", style: .default){ _ in
            self.resetGame()
        }
        let newGameAction = UIAlertAction(title: "返回主畫面 設定新局", style: .cancel) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }

        controller.addAction(resetAction)
        controller.addAction(newGameAction)
        present(controller, animated: true)
        
        }
    
    
    
    //A隊加分
    @IBAction func addScoreA(_ sender: Any) {
        
        //單局雙方合計未達13分移動圖示
        if scoreA + scoreB < 13 {
            scoreA += 1
            //單局得分圖示位置移動
            updatePlayerViewsPosition()
            //Array紀錄得分扣分
            getScoreArray.append(playerAScore)
            
        } else if scoreA + scoreB < 14 {
            //單局合計14分 計算雙方總分並顯示
            scoreA += 1
            updatePlayerViewsPosition()
            roundScoreA = roundScoreA + scoreA - foulScoreA
            roundScoreB = roundScoreB + scoreB - foulScoreB
            scoreALabel.text = roundScoreA.formatted()
            scoreBLabel.text = roundScoreB.formatted()
            getScoreArray.append(playerAScore)
        }
        //有設定獲勝分數 達標後會有獲勝提示
        if gameScore != nil && gameScore > 0{
            if scoreA + scoreB < 14 && (roundScoreA + scoreA - foulScoreA) == gameScore {
                showWinner()
            } else if scoreA + scoreB == 14 && roundScoreA == gameScore {
                showWinner()
            }
        }
        
        
    }
    

    
    @IBAction func addScoreB(_ sender: Any) {

        if scoreA + scoreB < 13 {
            scoreB += 1
            updatePlayerViewsPosition()
            getScoreArray.append(playerBScore)
        } else if scoreA + scoreB < 14 {
            scoreB += 1
            updatePlayerViewsPosition()
            roundScoreA = roundScoreA + scoreA - foulScoreA
            roundScoreB = roundScoreB + scoreB - foulScoreB
            scoreALabel.text = roundScoreA.formatted()
            scoreBLabel.text = roundScoreB.formatted()
            getScoreArray.append(playerBScore)
        }
        
        if gameScore != nil && gameScore > 0{
            if scoreA + scoreB < 14 && (roundScoreB + scoreB - foulScoreB) == gameScore {
                showWinner()
            } else if scoreA + scoreB == 14 && roundScoreB == gameScore {
                showWinner()
            }
        }
    }
    
    

    
    //A隊犯規扣分
    @IBAction func reduceScoreA(_ sender: Any) {
        
        if scoreA + scoreB != 14 {
            foulScoreA += 1
            foulALabel.text = foulScoreA.formatted()
            getScoreArray.append(playerAFoul)
        }
    }
    
   
    //B隊犯規扣分
    @IBAction func reduceScoreB(_ sender: Any) {
        
        if scoreA + scoreB != 14 {
            foulScoreB += 1
            foulBLabel.text = foulScoreB.formatted()
            getScoreArray.append(playerBFoul)
        }
    }
    
    
    @IBAction func reset(_ sender: Any) {
        
        let controller = UIAlertController(title: "維持原設定 重新比賽", message: "確定要用現有設定重新比賽？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default){ _ in
            self.resetGame()
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        present(controller, animated: true)
        
    }
    
    //繼續下一局
    @IBAction func changeNextGame(_ sender: Any) {
        //達到雙方進球總和14分 重置單局分數及得分圖示初始位置
        if scoreA + scoreB == 14 {
            scoreA = 0
            scoreB = 0
            foulScoreA = 0
            foulScoreB = 0
            rounds += 1
            foulALabel.text = foulScoreA.formatted()
            foulBLabel.text = foulScoreB.formatted()
            updatePlayerViewsPosition()
            totalScoreAArray.append(roundScoreA)
            totalScoreBArray.append(roundScoreB)
            getScoreArray.removeAll()
        }
    }
    
    
    //恢復上一步
    @IBAction func rewind(_ sender: Any) {
        //利用Array.popLast找出最後一步的操作
        let lastScore = getScoreArray.popLast()
        //判斷條件後 恢復上一步
        switch lastScore {
            
        case playerAScore:
            if scoreA + scoreB == 14 {
                scoreA -= 1
                updatePlayerViewsPosition()
                roundScoreA = totalScoreAArray[rounds]
                roundScoreB = totalScoreBArray[rounds]
                scoreALabel.text = roundScoreA.formatted()
                scoreBLabel.text = roundScoreB.formatted()
                
            } else {
                scoreA -= 1
                updatePlayerViewsPosition()
            }
            
        case playerBScore:
            if scoreA + scoreB == 14 {
                scoreB -= 1
                updatePlayerViewsPosition()
                roundScoreA = totalScoreAArray[rounds]
                roundScoreB = totalScoreBArray[rounds]
                scoreALabel.text = roundScoreA.formatted()
                scoreBLabel.text = roundScoreB.formatted()
                
            } else {
                scoreB -= 1
                updatePlayerViewsPosition()
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
    
    @IBAction func newGame(_ sender: Any) {
        
        let controller = UIAlertController(title: "返回主畫面 重開新局", message: "確定要返回主畫面重新設定玩家、獲勝條件嗎？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default){ _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }
    
    func updatePlayerViewsPosition() {
        switch scoreA {
        case 0:
            playerABallView.frame.origin.y = score0Label.frame.origin.y
        case 1:
            playerABallView.frame.origin.y = score1Label.frame.origin.y
        case 2:
            playerABallView.frame.origin.y = score2Label.frame.origin.y
        case 3:
            playerABallView.frame.origin.y = score3Label.frame.origin.y
        case 4:
            playerABallView.frame.origin.y = score4Label.frame.origin.y
        case 5:
            playerABallView.frame.origin.y = score5Label.frame.origin.y
        case 6:
            playerABallView.frame.origin.y = score6Label.frame.origin.y
        case 7:
            playerABallView.frame.origin.y = score7Label.frame.origin.y
        case 8:
            playerABallView.frame.origin.y = score8Label.frame.origin.y
        case 9:
            playerABallView.frame.origin.y = score9Label.frame.origin.y
        case 10:
            playerABallView.frame.origin.y = score10Label.frame.origin.y
        case 11:
            playerABallView.frame.origin.y = score11Label.frame.origin.y
        case 12:
            playerABallView.frame.origin.y = score12Label.frame.origin.y
        case 13:
            playerABallView.frame.origin.y = score13Label.frame.origin.y
        case 14:
            playerABallView.frame.origin.y = score14Label.frame.origin.y
        default:
            break
        }
        
        switch scoreB {
        case 0:
            playerBBallView.frame.origin.y = score0Label.frame.origin.y
        case 1:
            playerBBallView.frame.origin.y = score1Label.frame.origin.y
        case 2:
            playerBBallView.frame.origin.y = score2Label.frame.origin.y
        case 3:
            playerBBallView.frame.origin.y = score3Label.frame.origin.y
        case 4:
            playerBBallView.frame.origin.y = score4Label.frame.origin.y
        case 5:
            playerBBallView.frame.origin.y = score5Label.frame.origin.y
        case 6:
            playerBBallView.frame.origin.y = score6Label.frame.origin.y
        case 7:
            playerBBallView.frame.origin.y = score7Label.frame.origin.y
        case 8:
            playerBBallView.frame.origin.y = score8Label.frame.origin.y
        case 9:
            playerBBallView.frame.origin.y = score9Label.frame.origin.y
        case 10:
            playerBBallView.frame.origin.y = score10Label.frame.origin.y
        case 11:
            playerBBallView.frame.origin.y = score11Label.frame.origin.y
        case 12:
            playerBBallView.frame.origin.y = score12Label.frame.origin.y
        case 13:
            playerBBallView.frame.origin.y = score13Label.frame.origin.y
        case 14:
            playerBBallView.frame.origin.y = score14Label.frame.origin.y
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
