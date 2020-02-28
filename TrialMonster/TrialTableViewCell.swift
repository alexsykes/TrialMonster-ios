//
//  TrialTableViewCell.swift
//  TrialMonster
//
//  Created by Alex on 20/02/2020.
//  Copyright © 2020 Alex Sykes. All rights reserved.
//

import UIKit

class TrialTableViewCell: UITableViewCell {
    
// MARK: Properties
    
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var permitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
