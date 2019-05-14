//
//  ProjectsTableViewCell.swift
//  SwiftyCompanion
//
//  Created by Wahiba BELLAHCENE on 4/23/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    var projects: Projects_users? {
        didSet {
            if let p = projects {
                self.nameLabel.text = p.project?.name
                if let finalMark = p.final_mark {
                    self.gradeLabel.text = String(describing: finalMark)
                    self.gradeLabel.textColor = p.validated == true ? UIColor(red:0.37, green:0.71, blue:0.38, alpha:1.0) : UIColor(red:0.84, green:0.39, blue:0.44, alpha:1.0)
                } else {
                    self.gradeLabel.text = p.status
                    self.gradeLabel.textColor = UIColor(red:0.90, green:0.71, blue:0.58, alpha:1.0)
                }
            }
        }
    }
}
