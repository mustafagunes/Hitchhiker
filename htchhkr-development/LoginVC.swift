//
//  LoginVC.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 27.02.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindtoKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func handleScreenTap(sender : UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
