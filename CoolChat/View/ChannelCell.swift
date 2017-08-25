//
//  ChannelCell.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-25.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
            self.channelName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
            self.channelName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func configureCell(channel: Channel) {
        let title = "#\(channel.name ?? "")"
        channelName.text = title
    }

}
