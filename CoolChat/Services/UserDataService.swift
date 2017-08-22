//
//  UserDataService.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-21.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var color = ""
    public private(set) var avatar = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, email: String, name: String, avatar: String, color: String) {
        
        self.id = id
        self.color = color
        self.avatar = avatar
        self.email = email
        self.name = name
    }
    
    func setAvatar(avatar: String) {
        self.avatar = avatar
    }
}
