//
//  SkillsTableViewCell.swift
//  SwiftyCompanion
//
//  Created by Wahiba BELLAHCENE on 4/23/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    var skills: Skills? {
        didSet {
            if let s = skills {
                guard let lvl = s.level else {return}
                self.nameLabel.text = s.name
                self.percentLabel.text = String(describing: lvl)
            }
        }
    }
    
}
