//
//  HomeVC.swift
//  htchhkr-development
//
//  Created by Mustafa GUNES on 24.02.2018.
//  Copyright © 2018 Mustafa GUNES. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    
    var delegate : CenterVCDelegate?
    
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named : "launchScreenIcon")!, iconInitialSize: CGSize(width : 80, height : 80), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.popAndZoomOut
        revealingSplashView.startAnimation()
        
        revealingSplashView.heartAttack = true
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
    @IBAction func MenuBtnWasClicked(_ sender: Any) {
        
        delegate?.toggleLeftPanel()
    }
}
