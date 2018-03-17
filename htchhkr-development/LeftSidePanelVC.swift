//
//  LeftSidePanelVC.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 26.02.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {

    let appDelegate = AppDelegate.getAppDelegate()
    
    let currentUserId = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userAccountTypeLbl: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var loginOutBtn: UIButton!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var pickupModeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickupModeSwitch.isOn = false
        pickupModeSwitch.isHidden = true
        pickupModeLabel.isHidden = true
        
        observePassengersAndDrivers()
        
        if Auth.auth().currentUser == nil
        {
            userEmailLbl.text = ""
            userAccountTypeLbl.text = ""
            userImageView.isHidden = true
            loginOutBtn.setTitle(MSG_SIGN_UP_SIGN_IN, for: .normal)
        }
        else
        {
            userEmailLbl.text = Auth.auth().currentUser?.email
            userAccountTypeLbl.text = ""
            userImageView.isHidden = false
            loginOutBtn.setTitle(MSG_SIGN_OUT, for: .normal)
        }
    }
    
    func observePassengersAndDrivers() {
        
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for snap in snapshot
                {
                    if snap.key == Auth.auth().currentUser?.uid
                    {
                        self.userAccountTypeLbl.text = ACCOUNT_TYPE_PASSENGER
                    }
                }
            }
        })
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]
            {
                for snap in snapshot
                {
                    if snap.key == Auth.auth().currentUser?.uid
                    {
                        self.userAccountTypeLbl.text = ACCOUNT_TYPE_DRIVER
                        self.pickupModeSwitch.isHidden = false
                        
                        let switchStatus = snap.childSnapshot(forPath: ACCOUNT_PICKUP_MODE_ENABLED).value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickupModeLabel.isHidden = false
                    }
                }
            }
        })
    }
    
    @IBAction func switchWasToggled(_ sender: Any) {
        
        
//        // ASAGIDAKİ KOD DENEME AMACLI YAZILDI SİLMEYİ UNUTMA !!!!!!!
//        if pickupModeSwitch.isOn == true
//        {
//            pickupModeSwitch.isOn = false
//        }
//        else if pickupModeSwitch.isOn == false
//        {
//            pickupModeSwitch.isOn = true
//        }
        
        if pickupModeSwitch.isOn
        {
            pickupModeLabel.text = MSG_PICKUP_MODE_ENABLED
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues([ACCOUNT_PICKUP_MODE_ENABLED: true])
        }
        else
        {
            pickupModeLabel.text = MSG_PICKUP_MODE_DISABLED
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues([ACCOUNT_PICKUP_MODE_ENABLED: false])
        }
    }
    
    @IBAction func signUpLoginBtnWasClicked(_ sender: Any) {
        
        if Auth.auth().currentUser == nil
        {
            let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: VC_LOGIN) as? LoginVC
            present(loginVC!, animated: true, completion: nil)
            
        }
        else
        {
            do
            {
                try Auth.auth().signOut()
                
                userEmailLbl.text = ""
                userAccountTypeLbl.text = ""
                userImageView.isHidden = true
                pickupModeLabel.text = ""
                pickupModeSwitch.isHidden = true
                loginOutBtn.setTitle(MSG_SIGN_UP_SIGN_IN, for: .normal)
            }
            catch (let error)
            {
                print(error)
            }
        }
    }
}
