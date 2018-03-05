//
//  CenterVCDelegate.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 26.02.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
