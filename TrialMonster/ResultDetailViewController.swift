//
//  ResultDetailViewController.swift
//  TrialMonster
//
//  Created by Alex on 28/03/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class ResultDetailViewController: UIViewController {
    
    var result: Result?
    var trial: Trial?
    @IBOutlet var trialLabel: UILabel!
    @IBOutlet var bikeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let title = result!.name
        super.title = title

        trialLabel.text = trial?.name
        bikeLabel.text = "Machine: " + result!.machine
        courseLabel.text = "Course: " + result!.course
        if (result?.classs != "") {
        classLabel.text = "Class: " + result!.classs
        } else {
            classLabel.text = ""
        }
        numberLabel.text = "Rider: " + result!.rider
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
