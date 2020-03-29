//
//  SectionScoreCollectionViewCell.swift
//  TrialMonster
//
//  Created by Alex on 29/03/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class SectionScoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sectionNumberLabel: UILabel!
    @IBOutlet weak var sectionScoresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sectionNumberLabel.text = "One"
        sectionScoresLabel.text = "0123"
    }
    
    
//    func setup (section: String, score: String){
//       sectionScoresLabel.text = "score"
//    sectionNumberLabel.text = "on"
//    }
}
