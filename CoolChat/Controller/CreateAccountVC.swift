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
    
    var avatar = "profileDefault"
    var color = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatar != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatar)
            avatar = UserDataService.instance.avatar
        }
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    
                    if success {
                        AuthService.instance.addUser(name: name, email: email, avatarName: self.avatar, avatarColor: self.color, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.avatar)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func chooseAvatarBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATARS, sender: nil)
    }
    
    @IBAction func setColorBtnPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
