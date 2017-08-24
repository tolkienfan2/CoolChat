//
//  Constants.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-17.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//URL Constants
let BASE_URL = "https://creativeicecoolchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD = "\(BASE_URL)user/add"

//Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATARS = "toAvatarPicker"
let TO_PROFILE = "toProfile"

//User Defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = [
    "Content-Type": "application/json; charset = utf-8"
]

//Colors
let purplePlaceholder = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 0.5)

//Notification Constants
let NOTIFY_USER_DATA_DID_CHANGE = Notification.Name("notifyUserDataChanged")
