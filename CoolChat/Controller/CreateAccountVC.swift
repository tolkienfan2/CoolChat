//
//  CreateAccountVC.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-18.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        AuthService.instance.registerUser(email: email, password: pass, completion: { (success) in
            if success {
                print("registered new user!")
            }
        })
    }
    
    @IBAction func chooseAvatarBtnPressed(_ sender: Any) {
    }
    
    @IBAction func setColorBtnPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
