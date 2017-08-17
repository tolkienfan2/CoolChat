//
//  ChannelVC.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-17.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60

    }


}
