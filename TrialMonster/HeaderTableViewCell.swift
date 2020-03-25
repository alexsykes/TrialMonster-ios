//
//  HeaderTableViewCell.swift
//  TrialMonster
//
//  Created by Alex on 25/03/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var classLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(course: String) {
        classLabel.text = course
    }

}
