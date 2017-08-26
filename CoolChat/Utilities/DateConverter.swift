//
//  DateConverter.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-26.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import Foundation

extension Date {
    
    func ChatDateFormat(timestamp: String) -> String {

//        let 
        let chatDateFormat = DateFormatter()
        chatDateFormat.timeStyle = .none
        chatDateFormat.dateFormat = "EEEE, d MMM YYYY"
        return chatDateFormat.string(from: self)
    }
}

