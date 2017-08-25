//
//  SocketService.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-25.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        
        socket.emit("newChannel", name, description)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        
        socket.on("channelCreated") { (dataArray, ack) in
            guard let name = dataArray[0] as? String else { return }
            guard let description = dataArray[1] as? String else { return }
            guard let id = dataArray[2] as? String else { return }
            
            let newChannel = Channel(name: name, description: description, _id: id, _v: 0)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
}
