//
//  LoginVC.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 27.02.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    private var hideStatusBar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindtoKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)

        hideStatusBar = true
        
        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func handleScreenTap(sender : UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
