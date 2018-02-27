
//
//  UIViewExt.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 27.02.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeTo(alphaValue : CGFloat, withDuration duration : TimeInterval) {
        
        UIView.animate(withDuration: duration) {
            
            self.alpha = alphaValue
        }
    }
}
