//
//  AlertViewController.swift
//  billiard14-1
//
//  Created by 楊曜安 on 2023/3/11.
//

import UIKit

class AlertViewController: UIViewController {
    
    var winnerName: String!
    @IBOutlet weak var winnerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWinner()

        // Do any additional setup after loading the view.
    }
    
    func showWinner(){
        let winner = winnerName ?? "winner"
        winnerLabel.text = winner
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
