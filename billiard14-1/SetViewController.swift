//
//  SetViewController.swift
//  billiard14-1
//
//  Created by 楊曜安 on 2023/3/9.
//

import UIKit

class SetViewController: UIViewController {

    @IBOutlet weak var playerATextField: UITextField!
    @IBOutlet weak var playerBTextField: UITextField!
    @IBOutlet weak var gameScoreTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//            view.endEditing(true)
//        }
    
    
    //收鍵盤
    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func returnCloseKeyboard(_ sender: Any) {
    }
    
    
    //segue傳遞資料到計分板頁面
    @IBSegueAction func showResult(_ coder: NSCoder) -> ScoreViewController? {
        
        let setPlayerAName = String(playerATextField.text!)
        let setPlayerBName = String(playerBTextField.text!)
        let setGameScore = Int(gameScoreTextField.text!)

        let controller = ScoreViewController(coder: coder)
        
        controller?.playerAName = setPlayerAName
        controller?.playerBName = setPlayerBName
        controller?.gameScore = setGameScore
        
        
        return controller
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
