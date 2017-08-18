//
//  CreateAccountVC.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-18.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
