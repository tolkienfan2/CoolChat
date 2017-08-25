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
let URL_GET_CHANNELS = "\(BASE_URL)channel"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"

//Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATARS = "toAvatarPicker"
let TO_PROFILE = "toProfile"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byemail/"

//User Defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = [
    "Content-Type": "application/json; charset = utf-8"
]

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset = utf-8"
]

//Colors
let purplePlaceholder = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 0.5)

//Notification Constants
let NOTIFY_USER_DATA_DID_CHANGE = Notification.Name("userDataChanged")
let NOTIFY_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIFY_CHANNEL_SELECTED = Notification.Name("channelSelected")
let NOTIFY_MESSAGES_LOADED = Notification.Name("messagesLoaded")
