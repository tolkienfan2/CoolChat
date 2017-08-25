//
//  Channel.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-25.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    
    public private(set) var name: String!
    public private(set) var description: String?
    public private(set) var _id: String!
    public private(set) var _v: Int?
}
