//
//  MessageService.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-25.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    var messages = [Message]()
    var message: Message?
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                
                NotificationCenter.default.post(name: NOTIFY_CHANNELS_LOADED, object: nil)
                completion(true)
                
            } else {
                
                debugPrint(response.result.error as Any)
                completion(false)
            }

        }
    }
    
    func getChannelMessages(channelId: String, completion: @escaping CompletionHandler) {

        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else { return }
                
                do {
                    self.messages = try JSONDecoder().decode([Message].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                
                NotificationCenter.default.post(name: NOTIFY_MESSAGES_LOADED, object: nil)
                completion(true)
            
            } else {
                
                debugPrint(response.result.error as Any)
                completion(false)
           }
            
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearChannels() {
        channels.removeAll()
    }
}
