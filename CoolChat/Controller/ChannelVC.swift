//
//  ChannelVC.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-17.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
            
        } else {
        
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: . normal)
            userImg.image = UIImage(named: UserDataService.instance.avatar)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.color)
        } else {
            loginBtn.setTitle("Login", for: . normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
}
