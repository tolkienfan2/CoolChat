//
//  ChannelVC.swift
//  CoolChat
//
//  Created by Minni K Ang on 2017-08-17.
//  Copyright © 2017 CreativeIce. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIFY_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIFY_CHANNELS_LOADED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.usernameUpdated(_:)), name: NOTIFY_USER_NAME_UPDATED, object: nil)
        
        setupUserInfo()

        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
        SocketService.instance.getNewMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectedChannel?._id && AuthService.instance.isLoggedIn {
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
        
        SocketService.instance.loadUpdatedUsername { (updatedName) in
            self.loginBtn.setTitle(updatedName, for: .normal)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
        tableView.reloadData()
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
    
    @objc func usernameUpdated(_ notif: Notification) {
        loginBtn.setTitle(UserDataService.instance.name, for: .normal)
    }

    @objc func userDataDidChange(_ notif: Notification) {
        setupUserInfo()
        tableView.reloadData()
    }
    
    @objc func channelsLoaded(_ notif: Notification) {
        tableView.reloadData()
    }
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannelVC = AddChannelVC()
            addChannelVC.modalPresentationStyle = .custom
            present(addChannelVC, animated: true, completion: nil)
        }
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
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell {
                let channel = MessageService.instance.channels[indexPath.row]
                cell.configureCell(channel: channel)
                return cell
            } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel._id}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with: .none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: NOTIFY_CHANNEL_SELECTED, object: nil)
        
        self.revealViewController().revealToggle(animated: true)
        return
    }
}
