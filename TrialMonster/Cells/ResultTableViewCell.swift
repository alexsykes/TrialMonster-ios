//
//  ResultTableViewCell.swift
//  TrialMonster
//
//  Created by Alex Sykes on 25/02/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var RiderLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var CleansLabel: UILabel!
    @IBOutlet weak var OnesLabel: UILabel!
    @IBOutlet weak var TwosLabel: UILabel!
    @IBOutlet weak var ThreesLabel: UILabel!
    @IBOutlet weak var FivesLabel: UILabel!
    @IBOutlet weak var MissedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
