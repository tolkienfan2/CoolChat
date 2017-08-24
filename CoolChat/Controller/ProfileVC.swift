//
//  ProfileVC.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-24.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        userName.text = UserDataService.instance.name
        userImg.image = UIImage(named: UserDataService.instance.avatar)
        userEmail.text = UserDataService.instance.email
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.color)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
        }
    
    @IBAction func closeModalBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
}
