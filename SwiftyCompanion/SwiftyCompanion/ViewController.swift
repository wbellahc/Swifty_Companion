//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Wahiba BELLAHCENE on 4/8/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ManageUsers {
    
    var searchingAlready: Bool = false
    
    func Alerting() {
        let alert = UIAlertController(title: "Error", message: "The url is not valid, try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    var apiController: APIController = APIController()

    @IBOutlet weak var searchLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchLabel.isEnabled = false
        self.apiController.delegate = self
        if apiController.accessToken == nil {
            apiController.getAccessToken(){
                DispatchQueue.main.async {
                    print("\naccess token : ", self.apiController.accessToken as Any)
                    print("\n")
                    self.searchLabel.isEnabled = true
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let text = searchLabel.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchingAlready != true && text.isEmpty != true {
            searchingAlready = true
            apiController.getUsers(query: text)
        } else {
            searchLabel.text! = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successSearch" {
            if let pvc = segue.destination as? ProfileViewController, let user = sender as? UserData {
                pvc.current = user
            } else {
                DispatchQueue.main.async() { self.Alerting() }
            }
        } else {
            DispatchQueue.main.async() { self.Alerting() }
        }
    }
    
    func renderUser(user: UserData) {
        performSegue(withIdentifier: "successSearch", sender: user)
        searchingAlready = false
        print("\nuser : ", user)
        print("\n")
    }
    
}

