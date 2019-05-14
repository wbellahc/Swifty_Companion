//
//  AchievementsTableViewCell.swift
//  SwiftyCompanion
//
//  Created by Wahiba BELLAHCENE on 5/8/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class AchievementsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var achievements: Achievements? {
        didSet {
            if let a = achievements {
                self.nameLabel.text = a.name
                self.descriptionLabel.text = a.description
            }
        }
    }
}
