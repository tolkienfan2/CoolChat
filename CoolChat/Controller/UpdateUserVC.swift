//
//  UpdateUserVC.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-27.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class UpdateUserVC: UIViewController {

    @IBOutlet weak var currentUsernameLbl: UILabel!
    @IBOutlet weak var newUsername: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        currentUsernameLbl.text = UserDataService.instance.name
        newUsername.attributedPlaceholder = NSAttributedString(string: "new username", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UpdateUserVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func closeModalView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func updateUsername(_ sender: Any) {
        let user = UserDataService.instance
        let userId = user.id
        let email = user.email
        let avatar = user.avatar
        let color = user.color
        guard let newName = newUsername.text, newUsername.text != "" else { return }
        
        AuthService.instance.updateUser(name: newName, id: userId, email: email, avatar: avatar, color: color, completion: { (success) in
            if success {
                NotificationCenter.default.post(name: NOTIFY_USER_NAME_UPDATED, object: nil)
                SocketService.instance.updateUserById(name: newName, userId: userId, completion: { (success) in
                    SocketService.instance.socket.emit("name", user.name)
                    self.dismiss(animated: false, completion: nil)
                })
                
            }
        })
    }
}
