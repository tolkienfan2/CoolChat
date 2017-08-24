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
    
    func returnUIColor(components: String) -> UIColor {
        
        let scanner = Scanner(string:components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)

        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newUIColor
    }
}
