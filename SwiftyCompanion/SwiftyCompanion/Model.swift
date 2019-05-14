//
//  Model.swift
//  SwiftyCompanion
//
//  Created by Wahiba BELLAHCENE on 4/9/19.
//  Copyright © 2019 Wahiba BELLAHCENE. All rights reserved.
//

import Foundation

protocol ManageUsers: NSObjectProtocol {
    func renderUser(user: UserData)
    func Alerting()
}

struct User : Codable {
    var current: UserData?
}

struct UserData : Codable {
    let id : Int?
    let email : String?
    let login : String?
    let phone : String?
    let displayname : String?
    let image_url : String?
    let wallet : Int?
    let cursus_users : [Cursus_users]?
    let projects_users : [Projects_users]?
    let achievements : [Achievements]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case login = "login"
        case phone = "phone"
        case displayname = "displayname"
        case image_url = "image_url"
        case wallet = "wallet"
        case cursus_users = "cursus_users"
        case projects_users = "projects_users"
        case achievements = "achievements"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        displayname = try values.decodeIfPresent(String.self, forKey: .displayname)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        wallet = try values.decodeIfPresent(Int.self, forKey: .wallet)
        cursus_users = try values.decodeIfPresent([Cursus_users].self, forKey: .cursus_users)
        projects_users = try values.decodeIfPresent([Projects_users].self, forKey: .projects_users)
        achievements = try values.decodeIfPresent([Achievements].self, forKey: .achievements)
    }
}

struct Skills : Codable {
    let id : Int?
    let name : String?
    let level : Double?
        
    enum CodingKeys: String, CodingKey {
            
        case id = "id"
        case name = "name"
        case level = "level"
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        level = try values.decodeIfPresent(Double.self, forKey: .level)
    }
}

struct Project : Codable {
    let id : Int?
    let name : String?
    let parent_id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case parent_id = "parent_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        parent_id = try values.decodeIfPresent(Int.self, forKey: .parent_id)
    }
    
}

struct Projects_users : Codable {
    let id : Int?
    let final_mark : Int?
    let status : String?
    let validated : Bool?
    let project : Project?
    let cursus_ids : [Int]?
    let marked_at : String?
    
        enum CodingKeys: String, CodingKey {
            
        case id = "id"
        case final_mark = "final_mark"
        case status = "status"
        case validated = "validated?"
        case project = "project"
        case cursus_ids = "cursus_ids"
        case marked_at = "marked_at"
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        final_mark = try values.decodeIfPresent(Int.self, forKey: .final_mark)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        validated = try values.decodeIfPresent(Bool.self, forKey: .validated)
        project = try values.decodeIfPresent(Project.self, forKey: .project)
        cursus_ids = try values.decodeIfPresent([Int].self, forKey: .cursus_ids)
        marked_at = try values.decodeIfPresent(String.self, forKey: .marked_at)
    }
} 

struct Cursus_users : Codable {
    let level : Double?
    let skills : [Skills]?
    let cursus_id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case level = "level"
        case skills = "skills"
        case cursus_id = "cursus_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        level = try values.decodeIfPresent(Double.self, forKey: .level)
        skills = try values.decodeIfPresent([Skills].self, forKey: .skills)
        cursus_id = try values.decodeIfPresent(Int.self, forKey: .cursus_id)
    }
    
}

struct Achievements : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let tier : String?
    let kind : String?
    let visible : Bool?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case description = "description"
        case tier = "tier"
        case kind = "kind"
        case visible = "visible"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        tier = try values.decodeIfPresent(String.self, forKey: .tier)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        visible = try values.decodeIfPresent(Bool.self, forKey: .visible)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
