//
//  ProfileViewController.swift
//  SwiftyCompanion
//
//  Created by Wahiba BELLAHCENE on 4/15/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var current: UserData?
    
    var proj: [Projects_users] = []
    var achieve: [Achievements] = []
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    
    @IBOutlet weak var ProjectsTableView: UITableView!
    @IBOutlet weak var SkillsTableView: UITableView!
    @IBOutlet weak var AchieveTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == SkillsTableView {
            return (current?.cursus_users?.first?.skills?.count) ?? 0
        } else if tableView == ProjectsTableView {
            return proj.count
        } else if tableView == AchieveTableView {
            return achieve.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == SkillsTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as? SkillsTableViewCell {
                cell.skills = current?.cursus_users?.first?.skills?[indexPath.row]
                return cell
            }
        } else if tableView == ProjectsTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as? ProjectsTableViewCell {
                cell.projects = proj[indexPath.row]
                return cell
            }
        } else if tableView == AchieveTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "achievementCell") as? AchievementsTableViewCell {
                cell.achievements = achieve[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.getImages(current?.image_url)
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.profileImage.frame.size)
        gradient.colors = [UIColor.yellow.cgColor, UIColor.magenta.cgColor]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: self.profileImage.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.profileImage.layer.addSublayer(gradient)
        
        self.displayNameLabel.text = current?.displayname
        self.loginLabel.text = "Login : \(current?.login ?? "")"
        self.emailLabel.text = current?.email
        self.telLabel.text = current?.phone
        self.walletLabel.text = "Wallet : \(current?.wallet ?? 0)"
        myProgressBar(current)
        proj = (current?.projects_users?.filter({$0.project?.parent_id == nil && ($0.cursus_ids![0] == 1 || $0.cursus_ids![0] == 10)}))!
        achieve = (current?.achievements)!
    }
    
    func myProgressBar(_ user: UserData?)
    {
        if let lvl = current?.cursus_users?.first?.level {
            levelLabel.text = "Level : \(String(lvl))"
            progressView.setProgress(Float(lvl.truncatingRemainder(dividingBy: 1)), animated: true)
            progressView.transform = CGAffineTransform(scaleX: 1, y: 12)
        }
        else {
            levelLabel.text = "Unavailable"
            progressView.setProgress( 0 , animated: true)
            progressView.transform = CGAffineTransform(scaleX: 1, y: 12)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIImageView {

    func getImages(_ url_string: String?) {
        guard let img = url_string else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: img)!)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
    }
}
