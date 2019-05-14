//
//  APIController.swift
//  SwiftyCompanion
//
//  Created by Wahiba BELLAHCENE on 4/8/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import Foundation
import UIKit

let MY_UID: String = "#"
let SECRET: String = "#"
let BEARER = ((MY_UID + ":" + SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: [])

class APIController {
    weak var delegate : ManageUsers?
    var accessToken: String? = nil
    
    func validUser(user: UserData) -> Bool {
        guard (user.id != nil), (user.displayname != nil),
            (user.image_url != nil) else { return false }
        return true
    }
    
    func getAccessToken(completionHandler: @escaping () -> Swift.Void) {
        let url = NSURL(string: "https://api.intra.42.fr/oauth/token")
        let req = NSMutableURLRequest(url: url! as URL)
        req.httpMethod = "POST"
        let bodyData = "grant_type=client_credentials&client_id=\(MY_UID)&client_secret=\(SECRET)"
        req.httpBody = bodyData.data(using: String.Encoding.utf8)
        req.setValue("Bearer " + BEARER, forHTTPHeaderField: "Authorization")
        req.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: req as URLRequest) {
            (data, res, error) in
            if let err = error {
                print(err)
            }
            else if let jsonData = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let access = dic["access_token"] as? String {
                            self.accessToken = access
                            completionHandler()
                        }
                    }
                }
                catch(let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func getUsers(query: String) {
        let trimQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if let url = NSURL(string: "https://api.intra.42.fr/v2/users/\(trimQuery.lowercased())") {
            print("\nurl : ", url as Any)
            print("\n")
            let req = NSMutableURLRequest(url: url as URL)
            req.httpMethod = "GET"
            req.setValue("Bearer " + self.accessToken!, forHTTPHeaderField: "Authorization")
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: req as URLRequest) {
                (data, res, error) in
                if let err = error {
                    DispatchQueue.main.async { self.delegate?.Alerting() }
                    print(err)
                } else if let d = data {
                    do {
                        let dataUser = try JSONDecoder().decode(UserData.self, from: d)
                        if self.validUser(user: dataUser) == true {
                            DispatchQueue.main.async {
                                self.delegate?.renderUser(user: dataUser)
                            }
                            return
                        }
                    } catch (let err) {
                        DispatchQueue.main.async { self.delegate?.Alerting() }
                        print(err)
                    }
                }
            }
            task.resume()
        } else {
            DispatchQueue.main.async { self.delegate?.Alerting() }
        }
    }
}
