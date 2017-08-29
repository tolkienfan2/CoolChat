//
//  AuthService.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-21.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {

    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] =  [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString {
            (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }

    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {

        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] =  [
            "email": lowerCaseEmail,
            "password": password
        ]

        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON {
            (response) in
            
            if response.result.error == nil {

                guard let data = response.data else { return }
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
                
            } else {
                
                completion(false)
                debugPrint(response.result.error as Any)
          }
       }
    }
    
    func addUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func updateUser(name: String, id: String, email: String, avatar: String, color: String, completion: @escaping CompletionHandler) {
        let body: [String: Any] = [
            "name": name,
            "email": email,
            "avatarName": avatar,
            "avatarColor": color
        ]
        Alamofire.request("\(URL_UPDATE_USER)\(id)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
         
            if response.result.error == nil {

                completion(true)
                
            } else {
            
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
   func findUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func setUserInfo(data: Data) {
        let json = JSON(data: data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let avatar = json["avatarName"].stringValue
        let color = json["avatarColor"].stringValue
        
        UserDataService.instance.setUserData(id: id, email: email, name: name, avatar: avatar, color: color)
    }
}
